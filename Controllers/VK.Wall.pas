unit VK.Wall;

interface

uses
  System.SysUtils, System.Generics.Collections, REST.Client, VK.Controller, VK.Types,
  VK.Entity.Audio, System.JSON, VK.Entity.Media;

type
  TVkWallParams = record
    List: TParams;
    function Message(Value: string): Integer;
    function Attachments(Value: TAttachmentArray): Integer;
    function OwnerId(Value: Integer): Integer;
    function CloseComments(Value: Boolean): Integer;
    function FriendsOnly(Value: Boolean): Integer;
    function FromGroup(Value: Boolean): Integer;
    function Guid(Value: string): Integer;
    function LatLong(Lat, Long: Extended): Integer;
    function MarkAsAds(Value: Boolean): Integer;
    function MuteNotifications(Value: Boolean): Integer;
    function PlaceId(Value: Integer): Integer;
    function PostId(Value: Integer): Integer;
    function PublishDate(Value: TDateTime): Integer;
    function Services(Value: TArrayOfString): Integer;
    function Signed(Value: Boolean): Integer;
  end;

  TWallController = class(TVkController)
  public
    /// <summary>
    /// ��������� ������� ������ �� ����� �����
    /// </summary>
    /// <param name="PostId">�� ������</param>
    /// <param name="Message">����� �����</param>
    /// <param name="Attachments">��������</param>
    function Post(var PostId: Integer; Message: string; Attachments: TAttachmentArray = []): Boolean; overload;
    function Post(Message: string; Attachments: TAttachmentArray = []): Boolean; overload;
    function Post(var PostId: Integer; Message: string; OwnerId: Integer; Attachments:
      TAttachmentArray = []): Boolean; overload;
    function Post(Message: string; OwnerId: Integer; Attachments: TAttachmentArray = []): Boolean; overload;
    function Post(var PostId: Integer; Params: TVkWallParams): Boolean; overload;
    function Post(Params: TVkWallParams): Boolean; overload;
  end;

implementation

uses
  VK.API, VK.Utils, System.DateUtils;

{ TWallController }

function TWallController.Post(var PostId: Integer; Message: string; Attachments: TAttachmentArray = []): Boolean;
var
  Params: TParams;
  JSONItem: TJSONValue;
begin
  if not Attachments.IsEmpty then
    Params.Add('attachments', Attachments.ToString);
  if not Message.IsEmpty then
    Params.Add('message', Message);
  with Handler.Execute('wall.post', Params) do
  begin
    if Success then
    begin
      JSONItem := TJSONObject.ParseJSONValue(Response);
      PostId := JSONItem.GetValue<integer>('post_id', -1);
      JSONItem.Free;
      Result := True;
    end
    else
      Result := False;
  end;
end;

function TWallController.Post(Message: string; Attachments: TAttachmentArray): Boolean;
var
  PostId: Integer;
begin
  Result := Post(PostId, Message, Attachments);
end;

function TWallController.Post(Message: string; OwnerId: Integer; Attachments: TAttachmentArray): Boolean;
var
  PostId: Integer;
begin
  Result := Post(PostId, Message, OwnerId, Attachments);
end;

function TWallController.Post(var PostId: Integer; Message: string; OwnerId: Integer; Attachments:
  TAttachmentArray): Boolean;
var
  Params: TParams;
  JSONItem: TJSONValue;
begin
  if not Attachments.IsEmpty then
    Params.Add('attachments', Attachments.ToString);
  if not Message.IsEmpty then
    Params.Add('message', Message);
  Params.Add('owner_id', OwnerId);
  with Handler.Execute('wall.post', Params) do
  begin
    if Success then
    begin
      JSONItem := TJSONObject.ParseJSONValue(Response);
      PostId := JSONItem.GetValue<integer>('post_id', -1);
      JSONItem.Free;
      Result := True;
    end
    else
      Result := False;
  end;
end;

function TWallController.Post(Params: TVkWallParams): Boolean;
var
  PostId: Integer;
begin
  Result := Post(PostId, Params);
end;

function TWallController.Post(var PostId: Integer; Params: TVkWallParams): Boolean;
var
  JSONItem: TJSONValue;
begin
  with Handler.Execute('wall.post', Params.List) do
  begin
    if Success then
    begin
      JSONItem := TJSONObject.ParseJSONValue(Response);
      PostId := JSONItem.GetValue<integer>('post_id', -1);
      JSONItem.Free;
      Result := True;
    end
    else
      Result := False;
  end;
end;

{ TVkWallParams }

function TVkWallParams.Attachments(Value: TAttachmentArray): Integer;
begin
  Result := List.Add('attachments', Value.ToString);
end;

function TVkWallParams.CloseComments(Value: Boolean): Integer;
begin
  Result := List.Add('close_comments', BoolToString(Value));
end;

function TVkWallParams.FriendsOnly(Value: Boolean): Integer;
begin
  Result := List.Add('friends_only', BoolToString(Value));
end;

function TVkWallParams.FromGroup(Value: Boolean): Integer;
begin
  Result := List.Add('from_group', BoolToString(Value));
end;

function TVkWallParams.Guid(Value: string): Integer;
begin
  Result := List.Add('guid', Value);
end;

function TVkWallParams.LatLong(Lat, Long: Extended): Integer;
begin
  List.Add('lat', Lat.ToString);
  Result := List.Add('long', Long.ToString);
end;

function TVkWallParams.MarkAsAds(Value: Boolean): Integer;
begin
  Result := List.Add('mark_as_ads', BoolToString(Value));
end;

function TVkWallParams.Message(Value: string): Integer;
begin
  Result := List.Add('message', Value);
end;

function TVkWallParams.MuteNotifications(Value: Boolean): Integer;
begin
  Result := List.Add('mute_notifications', BoolToString(Value));
end;

function TVkWallParams.OwnerId(Value: Integer): Integer;
begin
  Result := List.Add('owner_id', Value.ToString);
end;

function TVkWallParams.PlaceId(Value: Integer): Integer;
begin
  Result := List.Add('place_id', Value.ToString);
end;

function TVkWallParams.PostId(Value: Integer): Integer;
begin
  Result := List.Add('post_id', Value.ToString);
end;

function TVkWallParams.PublishDate(Value: TDateTime): Integer;
begin
  Result := List.Add('publish_date', DateTimeToUnix(Value));
end;

function TVkWallParams.Services(Value: TArrayOfString): Integer;
begin
  Result := List.Add('services', Value.ToString);
end;

function TVkWallParams.Signed(Value: Boolean): Integer;
begin
  Result := List.Add('signed', BoolToString(Value));
end;

end.
