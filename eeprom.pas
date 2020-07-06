unit eeprom;

interface

procedure EEpromSend;

    procedure SendNextData;
    procedure SendDataAck(code: byte);
    procedure ReceiveNextData(var data : array of byte );

implementation

uses Classes, SysUtils, CanTest, Dialogs, DateUtils, System.Diagnostics;

var
    SendData : Boolean;
    ReceiveData : Boolean;
    ACKReceived : Boolean;

    MainStatus: Integer;

    SendPos : Integer;
    SendTime : TStopwatch;
    SendType : byte;
    SendSize : integer;
    SendBuffer: array[0..4095] of byte;
    ReceiveSize : Integer;


procedure EEpromSend;
var
  openDialog : topendialog;    // Open dialog variable
  F: TFileStream;
begin
  if ( MainStatus = 1) and ( not SendData ) then
  begin

    // Create the open dialog object - assign to our open dialog variable
    openDialog := TOpenDialog.Create(nil);

    // Set up the starting directory to be the current one
    openDialog.InitialDir := GetCurrentDir;

    // Only allow existing files to be selected
    openDialog.Options := [ofFileMustExist];

    // Allow only .dpr and .pas files to be selected
    openDialog.Filter :=
      'ECU EEPROM Datafile|*.dat';

    // Select pascal files as the starting filter type
    openDialog.FilterIndex := 1;

    // Display the open file dialog
    if openDialog.Execute
    then
    begin
      openDialog.FileName;

      F := TFileStream.Create(openDialog.FileName, fmOpenRead);
      try
        if F.Size = 4096 then
        begin
          F.Read(SendBuffer, 4096);
          SendType := 0;
          SendSize := 4096;
        end;

        if F.Size <= 1600 then
        begin
          F.Read(SendBuffer, F.Size);
          SendType := 1;
          SendSize := F.Size;
        end;
       // SendConfig.Enabled := false;
       // GetConfig.Enabled := false;
 //       Output.Items.Add('Sending EEPROM Data.');
        SendData := true;

        SendPos := -1;
        SendNextData;
      Except
  //      Output.Items.Add('Error reading data.');

      end;

      F.Free;

    end;
 //   else ShowMessage('Sending cancelled.');

    // Free up the dialog
    openDialog.Free;
  end;
end;

procedure timer100ms;
begin
  if SendData then  // ensure timeout runs
  begin
     if SendTime.ElapsedMilliseconds > 1000  then
      begin
        // timeout
        ReceiveData := false;
        SendPos := -1;
     //   SendConfig.Enabled := true;
      //  GetConfig.Enabled := true;
      //  Output.Items.Add('Send Timeout');
      end;
  end;

  if ReceiveData then  // ensure timeout runs
  begin
     if SendTime.ElapsedMilliseconds > 1000  then
      begin
        // timeout
        ReceiveData := false;
        SendPos := -1;
   //     SendConfig.Enabled := true;
    //    GetConfig.Enabled := true;
    //    Output.Items.Add('Receive Timeout');
      end;
  end;
end;



procedure SendDataAck(code: byte);
var
  msg: array[0..7] of byte;
begin
        msg[0] := 30; // send err
        msg[1] := code;
        MainForm.CanSend($21,msg,3,0);
end;

procedure ReceiveNextData( var data: array of byte );
var
  receivepos : integer;
  msg: array[0..7] of byte;
  F: TFileStream;
  saveDialog : tsavedialog;    // Save dialog variable
begin

		 receivepos := data[1]*256+data[2];
			// check receive buffer address matches sending position
			if ( receivepos <> SendPos ) then
      begin
				// unexpected data sequence, reset receive status;

		//		resetReceive();
	 //			Output.Items.add('Receive OutSeq.');
        SendDataAck(99);
			 //	CAN_SendStatus(ReceivingData,ReceiveErr,0);
			end else // position good, continue.
			begin

				if SendPos+data[3]<=4096 then
				begin

          move(data[4], SendBuffer[SendPos], data[3]);

					if (data[3] < 4) then // data received ok, but wasn't full block. end of data.
					begin
            Inc(Sendpos, data[3]);
            SendDataAck(1);
					end else
					begin
            Inc(Sendpos, 4);
            SendDataAck(1);
					end;

          if (data[3] = 0 ) then
          begin
						ReceiveData := false;
     //       GetConfig.Enabled := true;
     //       SendConfig.Enabled := true;
		 //				Output.Items.Add('Receive Done.');


            // Create the save dialog object - assign to our save dialog variable
            saveDialog := TSaveDialog.Create(nil);

            // Give the dialog a title
            saveDialog.Title := 'Save ECU Config data.';

            // Set up the starting directory to be the current one
            saveDialog.InitialDir := GetCurrentDir;

            // Allow only .txt and .doc file types to be saved
            saveDialog.Filter := 'ECU EEPROM Datafile|*.dat';

            saveDialog.FileName := 'ECUEEPROM.dat';

            // Set the default extension
            saveDialog.DefaultExt := 'dat';

            // Select text files as the starting filter type
            saveDialog.FilterIndex := 1;

            // Display the open file dialog
            if saveDialog.Execute
            then
            begin
              saveDialog.FileName;
              try
                F := TFileStream.Create(saveDialog.FileName, fmCreate);

                if F.Size = 0 then
                begin
                  F.Write(SendBuffer, SendPos);
                end;
        //        Output.Items.Add('File saved.');

              except
         //       Output.Items.Add('Error writing file');
              end;
              F.Free;
            end;
          //  else ShowMessage('Save file was cancelled');

            // Free up the dialog
            saveDialog.Free;


          end;

				end else
				begin
					// TODO tried to receive too much data! error.
		 //			resetReceive();
     //		lcd_send_stringpos(3,0,"Receive Error.    ");
		 //			CAN_SendStatus(ReceivingData, ReceiveErr,0);
          msg[0] := 30; // send err
          msg[1] := 99;
          MainForm.CanSend($21,msg,3,0);
          MainForm.Output.Items.add('Receive Err.');
				end
			end;
end;

procedure SendNextData;
var
  msg: array[0..7] of byte;
  I : integer;
  packetsize : byte;
begin
 // with CanChannel1 do
    begin
   //   if Active then
      begin
        if SendData then  // if request to send data activated.
        begin
          if SendPos = -1 then
          begin
      //      for I := 0 to 4095 do SendBuffer[I] := I;
            msg[0] := 8;

            msg[1] := byte(SendSize shr 8);
            msg[2] := byte(SendSize);

            msg[3] := SendType;

            SendPos := 0;

            MainForm.CanSend($21,msg,4,0);  // send start of transfer.
            SendTime := TStopwatch.StartNew;
          end else
          begin
          if ACKReceived then //and ( SendTime.ElapsedMilliseconds > 100 ) then
            begin
              ACKReceived := false;
              if sendpos < sendsize-1 then // not yet at end
              begin

        //        Output.Items.Add('Send:'+inttostr(sendpos));
                msg[0] := 9; // sending byte.

                packetsize := 4;


                msg[1] := byte(sendpos shr 8);
                msg[2] := byte(sendpos);


                if ( SendPos+packetsize > Sendsize ) then
                  packetsize := sendsize-sendpos;

                msg[3] := packetsize;

                msg[4] := SendBuffer[sendpos];
                msg[5] := SendBuffer[sendpos+1];
                msg[6] := SendBuffer[sendpos+2];
                msg[7] := SendBuffer[sendpos+3];
                sendpos := sendpos+4;

                MainForm.CanSend($21,msg,8,0);

  //              Sleep(100);
              end else
              if sendpos >= sendsize-1 then
              begin
                sendpos := sendsize;
                msg[1] := byte(sendpos shr 8);
                msg[2] := byte(sendpos);

                for I := 3 to 7 do msg[I] := 0;

                MainForm.CanSend($21,msg,8,0);
                SendData := false;
                //SendConfig.Enabled := true;
                //GetConfig.Enabled := true;
                //Output.Items.Add('Send Done');

              end;

            end;
          end;

      end;
    end;

  end;
end;



procedure GetConfigClick(Sender: TObject);
var
  msg: array[0..7] of byte;
begin
 // with CanChannel1 do
  begin
   // if Active then
    begin
      if ( MainStatus = 1) and ( not SendData ) then  // only send request if in startup state.
      begin

        msg[0] := 10;
        msg[1] := 1; // specify full EEPROM = 0

    //    GetConfig.Enabled := false;
     //   SendConfig.Enabled := false;
   //     Output.Items.Add('Getting EEPROM Data.');
        ReceiveData := true;
        SendPos := 0;
        MainForm.CanSend($21,msg,8,0);
        SendTime := TStopwatch.StartNew;
      end;
    end;
  end;

end;



procedure testeepromwriteClick(Sender: TObject);
var
  msg: array[0..7] of byte;
begin
  msg[0] := 11;
 // with CanChannel1 do
  begin
 //   if Active then
    begin
      if MainStatus = 1 then  // only send request if in startup state.
      begin
        MainForm.CanSend($21,msg,3,0);
    //    Output.Items.Add('EEPROM Write Request');
      end;
    end;
  end;
end;

procedure datacanreceive21( msg :array of byte; id : integer);
begin
  if id = $21 then
  begin     // data receive
    if ReceiveData then
    begin
      if msg[0] = 8 then  // receive data.
      begin
        ReceiveSize := msg[1]*256+msg[2];
        SendPos := 0;
        SendDataAck(1);
     //   Output.Items.Add('StartReceive('+inttostr(Receivesize)+')');
        SendTime := TStopwatch.StartNew;
      end;

      if msg[0] = 9 then  // receive data.
      begin
//            Output.Items.Add('RCV block');;
         ReceiveNextData(msg);
         SendTime.Reset;
         SendTime.Start;
      end;
    end;
  end;
end;

procedure datacanreceive20( msg :array of byte; id : integer);
begin
  if msg[0] = 30 then  // receive data.

    // message sending
    if msg[1] = 1 then
    begin
  //      Output.Items.Add('DataAck');
      ACKReceived := true;
      SendTime.Reset;
      SendTime.Start;
      SendNextData;
    end else if msg[1] = 99 then
    begin
   //   Output.Items.Add('DataErr!');
      ACKReceived := false;
      SendData := false;
      SendTime.Stop;
      SendNextData;
   //   SendConfig.Enabled := true;
    end;
end;

initialization
  SendData := false;
  ACKReceived := false;
end.
