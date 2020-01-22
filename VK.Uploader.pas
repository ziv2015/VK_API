unit VK.Uploader;

interface

uses
  System.SysUtils, System.Types, System.UITypes, Vcl.Dialogs, System.Classes, System.Variants,
  REST.Client, System.JSON, System.Net.HttpClient, VK.Types, System.Net.Mime;

type
  TUploader = class
    function Upload(UploadUrl: string; FileName: string; var Response: string): Boolean; overload;
  end;

implementation

{ TUploader }

function TUploader.Upload(UploadUrl, FileName: string; var Response: string): Boolean;
var
  HTTP: THTTPClient;
  Data: TMultipartFormData;
  ResStream: TStringStream;
  JSON: TJSONValue;
begin
  Data := TMultipartFormData.Create;
  HTTP := THTTPClient.Create;
  ResStream := TStringStream.Create;
  try
    Data.AddFile('file', FileName);
    if HTTP.Post(UploadUrl, Data, ResStream).StatusCode = 200 then
    begin
      try
        JSON := TJSONObject.ParseJSONValue(ResStream.DataString);
        Response := JSON.GetValue<string>('file');
        JSON.Free;
      except
        Response := '';
      end;
      Result := not Response.IsEmpty;
      if not Result then
        Response := ResStream.DataString;
    end
    else
      Result := False;
  finally
    Data.Free;
    HTTP.Free;
    ResStream.Free;
  end;
end;

end.
