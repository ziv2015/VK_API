unit VK.Entity.Group;

interface

uses
  Generics.Collections, Rest.Json, VK.Entity.Common, VK.Entity.Photo, VK.Entity.Market, VK.Entity.User;

type
  TVkGroupStatusType = (gsNone, gsOnline, gsAnswerMark);

  TVkGroupSubject = TVkBasicObject;

  TVkGroupStatus = class
  private
    FMinutes: Integer;
    FStatus: string;
    function GetStatus: TVkGroupStatusType;
  public
    /// <summary>
    /// ������ ������� ������ � ������� (��� status = answer_mark)
    /// </summary>
    property Minutes: Integer read FMinutes write FMinutes;
    /// <summary>
    /// C����� ����������
    /// </summary>
    /// <returns>none � ���������� �� ������; online � ���������� ������ (�������� ���������); answer_mark � ���������� �������� ������.</returns>
    property StatusStr: string read FStatus write FStatus;
    /// <summary>
    /// C����� ����������
    /// </summary>
    property Status: TVkGroupStatusType read GetStatus;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkGroupStatus;
  end;

  TVkCoverImage = record
  private
    FWidth: Integer;
    FUrl: string;
    FHeight: Integer;
  public
    property Url: string read FUrl write FUrl;
    property Width: Integer read FWidth write FWidth;
    property Height: Integer read FHeight write FHeight;
  end;

  TVkCover = class
  private
    FEnabled: Integer;
    FImages: TArray<TVkCoverImage>;
  public
    property Enabled: Integer read FEnabled write FEnabled;
    property Images: TArray<TVkCoverImage> read FImages write FImages;
  end;

  TVkGroupLink = class
  private
    FName: string;
    FPhoto_50: string;
    FId: Integer;
    FUrl: string;
    FDesc: string;
    FPhoto_100: string;
    FEdit_title: Integer;
    FImage_processing: Integer;
  public
    property Id: Integer read FId write FId;
    property Url: string read FUrl write FUrl;
    property Name: string read FName write FName;
    property Desc: string read FDesc write FDesc;
    property Photo_50: string read FPhoto_50 write FPhoto_50;
    property Photo_100: string read FPhoto_100 write FPhoto_100;
    property EditTitle: Integer read FEdit_title write FEdit_title;
    property ImageProcessing: Integer read FImage_processing write FImage_processing;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkGroupLink;
  end;

  TVkGroupMemberState = class
  private
    FMember: Integer;
    FUser_id: Integer;
    FCan_invite: Integer;
    FRequest: Integer;
    FInvitation: Integer;
    FCan_recall: Integer;
    function GetCan_invite: Boolean;
    function GetCan_recall: Boolean;
    function GetInvitation: Boolean;
    function GetMember: Boolean;
    function GetRequest: Boolean;
    procedure SetCan_invite(const Value: Boolean);
    procedure SetCan_recall(const Value: Boolean);
    procedure SetInvitation(const Value: Boolean);
    procedure SetMember(const Value: Boolean);
    procedure SetRequest(const Value: Boolean);
  public
    /// <summary>
    /// �������� �� ������������ ���������� ����������
    /// </summary>
    property Member: Boolean read GetMember write SetMember;
    /// <summary>
    /// ���� �� ���������� ������ �� ������������ �� ���������� � ������ (����� ������ ����� �������� ������� Groups.Leave)
    /// </summary>
    property Request: Boolean read GetRequest write SetRequest;
    /// <summary>
    /// ��������� �� ������������ � ������ ��� �������
    /// </summary>
    property Invitation: Boolean read GetInvitation write SetInvitation;
    /// <summary>
    /// ����� �� ����� ������� ���������� ������������ � ������
    /// </summary>
    property CanInvite: Boolean read GetCan_invite write SetCan_invite;
    /// <summary>
    /// ����� �� ����� �������� �����������. ����������, ���� Invitation: True
    /// </summary>
    property CanRecall: Boolean read GetCan_recall write SetCan_recall;
    /// <summary>
    /// ������������� ������������.
    /// </summary>
    property UserId: Integer read FUser_id write FUser_id;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkGroupMemberState;
  end;

  TVkGroupMemberStates = class
  private
    FItems: TArray<TVkGroupMemberState>;
  public
    property Items: TArray<TVkGroupMemberState> read FItems write FItems;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkGroupMemberStates;
  end;

  TVkGroupMarket = class
  private
    FName: string;
    FEnabled: Integer;
    FMain_album_id: Integer;
    FPrice_min: Integer;
    FCurrency_text: string;
    FId: Integer;
    FPrice_max: Integer;
    FContact_id: Integer;
    FCurrency: TVkProductCurrency;
  public
    property Enabled: Integer read FEnabled write FEnabled;
    property PriceMin: Integer read FPrice_min write FPrice_min;
    property PriceMax: Integer read FPrice_max write FPrice_max;
    property MainAlbumId: Integer read FMain_album_id write FMain_album_id;
    property ContactId: Integer read FContact_id write FContact_id;
    property Currency: TVkProductCurrency read FCurrency write FCurrency;
    property Id: Integer read FId write FId;
    property Name: string read FName write FName;
    property Currency_text: string read FCurrency_text write FCurrency_text;
  end;

  TVkGroupAddress = class
  private
    FAdditional_address: string;
    FAddress: string;
    FCity_id: Integer;
    FCountry_id: Integer;
    FId: Integer;
    FLatitude: Extended;
    FLongitude: Extended;
    FMetro_station_id: Integer;
    FTime_offset: Integer;
    FTitle: string;
    FWork_info_status: string;
  public
    property Additional_address: string read FAdditional_address write FAdditional_address;
    property Address: string read FAddress write FAddress;
    property CityId: Integer read FCity_id write FCity_id;
    property CountryId: Integer read FCountry_id write FCountry_id;
    property Id: Integer read FId write FId;
    property Latitude: Extended read FLatitude write FLatitude;
    property Longitude: Extended read FLongitude write FLongitude;
    property MetroStationId: Integer read FMetro_station_id write FMetro_station_id;
    property TimeOffset: Integer read FTime_offset write FTime_offset;
    property Title: string read FTitle write FTitle;
    property WorkInfoStatus: string read FWork_info_status write FWork_info_status;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkGroupAddress;
  end;

  TVkGroupAddresses = class
  private
    FItems: TArray<TVkGroupAddress>;
  public
    property Items: TArray<TVkGroupAddress> read FItems write FItems;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkGroupAddresses;
  end;

  TVkGroup = class
  private
    FAdmin_level: Extended;
    FId: Int64;
    FIs_admin: Integer;
    FIs_advertiser: Integer;
    FIs_closed: Integer;
    FIs_member: Integer;
    FName: string;
    FPhoto_100: string;
    FPhoto_200: string;
    FPhoto_50: string;
    FScreen_name: string;
    FType: string;
    FTrending: Integer;
    FMembers_count: Integer;
    FVerified: Integer;
    FCountry: TVkCountry;
    FMember_status: Integer;
    FCity: TVkCity;
    FActivity: string;
    FDeactivated: string;
    FInvited_by: Integer;
    FAddresses: TVkAddresses;
    FAge_limits: Integer;
    FBan_info: TVkBanInfo;
    Fcan_create_topic: Integer;
    Fcan_message: Integer;
    Fcan_post: Integer;
    Fcan_see_all_posts: Integer;
    Fcan_upload_doc: Integer;
    Fcan_upload_video: Integer;
    FContacts: TArray<TVkContact>;
    FCover: TVkCover;
    FCrop_photo: TVkCropPhoto;
    FDescription: string;
    FFixed_post: Integer;
    FHas_photo: Integer;
    FIs_favorite: Integer;
    FIs_hidden_from_feed: Integer;
    FIs_messages_blocked: Integer;
    FLinks: TArray<TVkGroupLink>;
    FMain_album_id: Integer;
    FMain_section: Integer;
    FMarket: TVkGroupMarket;
    FPlace: TVkPlace;
    FPublic_date_label: string;
    FSite: string;
    FStatus: string;
    FWall: Integer;
    FWiki_page: string;
    function GetIs_admin: Boolean;
    procedure SetIs_admin(const Value: Boolean);
    function GetIs_advertiser: Boolean;
    function GetIs_closed: Boolean;
    function GetIs_member: Boolean;
    procedure SetIs_advertiser(const Value: Boolean);
    procedure SetIs_closed(const Value: Boolean);
    procedure SetIs_member(const Value: Boolean);
    function GetVerified: Boolean;
    procedure SetVerified(const Value: Boolean);
  public
    property Activity: string read FActivity write FActivity;
    property AdminLevel: Extended read FAdmin_level write FAdmin_level;
    property Addresses: TVkAddresses read FAddresses write FAddresses;
    /// <summary>
    /// 1 � ���; 2 � 16+; 3 � 18+.
    /// </summary>
    property AgeLimits: Integer read FAge_limits write FAge_limits;
    property BanInfo: TVkBanInfo read FBan_info write FBan_info;
    property CanCreateTopic: Integer read Fcan_create_topic write Fcan_create_topic;
    property CanMessage: Integer read Fcan_message write Fcan_message;
    property CanPost: Integer read Fcan_post write Fcan_post;
    property CanSeeAllPosts: Integer read Fcan_see_all_posts write Fcan_see_all_posts;
    property CanUploadDoc: Integer read Fcan_upload_doc write Fcan_upload_doc;
    property CanUploadVideo: Integer read Fcan_upload_video write Fcan_upload_video;
    property City: TVkCity read FCity write FCity;
    property Contacts: TArray<TVkContact> read FContacts write FContacts;
    property Country: TVkCountry read FCountry write FCountry;
    property Cover: TVkCover read FCover write FCover;
    property CropPhoto: TVkCropPhoto read FCrop_photo write FCrop_photo;
    property Deactivated: string read FDeactivated write FDeactivated;
    property Description: string read FDescription write FDescription;
    property FixedPost: Integer read FFixed_post write FFixed_post;
    property HasPhoto: Integer read FHas_photo write FHas_photo;
    property Id: Int64 read FId write FId;
    property InvitedBy: Integer read FInvited_by write FInvited_by;
    property IsAdmin: Boolean read GetIs_admin write SetIs_admin;
    property IsAdvertiser: Boolean read GetIs_advertiser write SetIs_advertiser;
    property IsClosed: Boolean read GetIs_closed write SetIs_closed;
    property IsFavorite: Integer read FIs_favorite write FIs_favorite;
    property IsHiddenFromFeed: Integer read FIs_hidden_from_feed write FIs_hidden_from_feed;
    property IsMessagesBlocked: Integer read FIs_messages_blocked write FIs_messages_blocked;
    property IsMember: Boolean read GetIs_member write SetIs_member;
    property Links: TArray<TVkGroupLink> read FLinks write FLinks;
    property MainAlbumId: Integer read FMain_album_id write FMain_album_id;
    property MainSection: Integer read FMain_section write FMain_section;
    property Market: TVkGroupMarket read FMarket write FMarket;
    property MembersCount: Integer read FMembers_count write FMembers_count;
    property MemberStatus: Integer read FMember_status write FMember_status;
    property Name: string read FName write FName;
    property Photo100: string read FPhoto_100 write FPhoto_100;
    property Photo200: string read FPhoto_200 write FPhoto_200;
    property Photo50: string read FPhoto_50 write FPhoto_50;
    property Place: TVkPlace read FPlace write FPlace;
    property PublicDateLabel: string read FPublic_date_label write FPublic_date_label;
    property ScreenName: string read FScreen_name write FScreen_name;
    property Site: string read FSite write FSite;
    property Status: string read FStatus write FStatus;
    property&Type: string read FType write FType;
    property Trending: Integer read FTrending write FTrending;
    property Verified: Boolean read GetVerified write SetVerified;
    property Wall: Integer read FWall write FWall;
    property WikiPage: string read FWiki_page write FWiki_page;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkGroup;
  end;

  TVkGroups = class
  private
    FItems: TArray<TVkGroup>;
    FCount: Integer;
    FSaveObjects: Boolean;
    procedure SetSaveObjects(const Value: Boolean);
  public
    property Items: TArray<TVkGroup> read FItems write FItems;
    property Count: Integer read FCount write FCount;
    property SaveObjects: Boolean read FSaveObjects write SetSaveObjects;
    procedure Append(Users: TVkGroups);
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkGroups;
  end;

  TVkInvitesGroups = class
  private
    FItems: TArray<TVkGroup>;
    FCount: Integer;
    FGroups: TArray<TVkGroup>;
    FProfiles: TArray<TVkUser>;
  public
    property Items: TArray<TVkGroup> read FItems write FItems;
    property Groups: TArray<TVkGroup> read FGroups write FGroups;
    property Profiles: TArray<TVkUser> read FProfiles write FProfiles;
    property Count: Integer read FCount write FCount;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkInvitesGroups;
  end;

  TVkGroupTag = class
  private
    FColor: string;
    FId: Integer;
    FName: string;
  public
    property Color: string read FColor write FColor;
    property Id: Integer read FId write FId;
    property Name: string read FName write FName;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkGroupTag;
  end;

  TVkGroupTags = class
  private
    FItems: TArray<TVkGroupTag>;
    FCount: Integer;
  public
    property Items: TArray<TVkGroupTag> read FItems write FItems;
    property Count: Integer read FCount write FCount;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkGroupTags;
  end;

function FindGroup(Id: Integer; List: TArray<TVkGroup>): Integer;

implementation

uses
  VK.CommonUtils;

function FindGroup(Id: Integer; List: TArray<TVkGroup>): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := Low(List) to High(List) do
    if List[i].Id = Abs(Id) then
      Exit(i);
end;

{TVkGroup}

function TVkGroup.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

constructor TVkGroup.Create;
begin
  inherited;
end;

destructor TVkGroup.Destroy;
var
  LItemsItem: TVkContact;
  LLinksItem: TVkGroupLink;
begin
  for LItemsItem in FContacts do
    LItemsItem.Free;
  for LLinksItem in FLinks do
    LLinksItem.Free;

  if Assigned(FCity) then
    FCity.Free;
  if Assigned(FCountry) then
    FCountry.Free;
  if Assigned(FAddresses) then
    FAddresses.Free;
  if Assigned(FBan_info) then
    FBan_info.Free;
  if Assigned(FCover) then
    FCover.Free;
  if Assigned(FCrop_photo) then
    FCrop_photo.Free;
  if Assigned(FMarket) then
    FMarket.Free;
  inherited;
end;

class function TVkGroup.FromJsonString(AJsonString: string): TVkGroup;
begin
  result := TJson.JsonToObject<TVkGroup>(AJsonString)
end;

function TVkGroup.GetIs_admin: Boolean;
begin
  Result := FIs_admin = 1;
end;

function TVkGroup.GetIs_advertiser: Boolean;
begin
  Result := FIs_advertiser = 1;
end;

function TVkGroup.GetIs_closed: Boolean;
begin
  Result := FIs_closed = 1;
end;

function TVkGroup.GetIs_member: Boolean;
begin
  Result := FIs_member = 1;
end;

function TVkGroup.GetVerified: Boolean;
begin
  Result := FVerified = 1;
end;

procedure TVkGroup.SetIs_admin(const Value: Boolean);
begin
  FIs_admin := BoolToInt(Value);
end;

procedure TVkGroup.SetIs_advertiser(const Value: Boolean);
begin
  FIs_advertiser := BoolToInt(Value);
end;

procedure TVkGroup.SetIs_closed(const Value: Boolean);
begin
  FIs_closed := BoolToInt(Value);
end;

procedure TVkGroup.SetIs_member(const Value: Boolean);
begin
  FIs_member := BoolToInt(Value);
end;

procedure TVkGroup.SetVerified(const Value: Boolean);
begin
  FVerified := BoolToInt(Value);
end;

{ TVkGroupStatus }

function TVkGroupStatus.GetStatus: TVkGroupStatusType;
begin
  if FStatus = 'none' then
    Exit(gsNone);
  if FStatus = 'online' then
    Exit(gsOnline);
  if FStatus = 'answer_mark' then
    Exit(gsAnswermark);
  Result := gsNone;
end;

function TVkGroupStatus.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TVkGroupStatus.FromJsonString(AJsonString: string): TVkGroupStatus;
begin
  result := TJson.JsonToObject<TVkGroupStatus>(AJsonString)
end;

{ TVkGroups }

procedure TVkGroups.Append(Users: TVkGroups);
var
  OldLen: Integer;
begin
  OldLen := Length(Items);
  SetLength(FItems, OldLen + Length(Users.Items));
  Move(Users.Items[0], FItems[OldLen], Length(Users.Items) * SizeOf(TVkGroup));
end;

constructor TVkGroups.Create;
begin
  inherited;
  FSaveObjects := False;
end;

destructor TVkGroups.Destroy;
var
  LItemsItem: TVkGroup;
begin
  if not FSaveObjects then
  begin
    for LItemsItem in FItems do
      LItemsItem.Free;
  end;

  inherited;
end;

class function TVkGroups.FromJsonString(AJsonString: string): TVkGroups;
begin
  result := TJson.JsonToObject<TVkGroups>(AJsonString);
end;

procedure TVkGroups.SetSaveObjects(const Value: Boolean);
begin
  FSaveObjects := Value;
end;

function TVkGroups.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

{ TVkGroupMemberStates }

destructor TVkGroupMemberStates.Destroy;
var
  LItemsItem: TVkGroupMemberState;
begin
  for LItemsItem in FItems do
    LItemsItem.Free;
  inherited;
end;

class function TVkGroupMemberStates.FromJsonString(AJsonString: string): TVkGroupMemberStates;
begin
  result := TJson.JsonToObject<TVkGroupMemberStates>(AJsonString);
end;

function TVkGroupMemberStates.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

{ TVkGroupMemberState }

class function TVkGroupMemberState.FromJsonString(AJsonString: string): TVkGroupMemberState;
begin
  result := TJson.JsonToObject<TVkGroupMemberState>(AJsonString);
end;

function TVkGroupMemberState.GetCan_invite: Boolean;
begin
  Result := FCan_invite = 1;
end;

function TVkGroupMemberState.GetCan_recall: Boolean;
begin
  Result := FCan_recall = 1;
end;

function TVkGroupMemberState.GetInvitation: Boolean;
begin
  Result := FInvitation = 1;
end;

function TVkGroupMemberState.GetMember: Boolean;
begin
  Result := FMember = 1;
end;

function TVkGroupMemberState.GetRequest: Boolean;
begin
  Result := FRequest = 1;
end;

procedure TVkGroupMemberState.SetCan_invite(const Value: Boolean);
begin
  FCan_invite := BoolToInt(Value);
end;

procedure TVkGroupMemberState.SetCan_recall(const Value: Boolean);
begin
  FCan_recall := BoolToInt(Value);
end;

procedure TVkGroupMemberState.SetInvitation(const Value: Boolean);
begin
  FInvitation := BoolToInt(Value);
end;

procedure TVkGroupMemberState.SetMember(const Value: Boolean);
begin
  FMember := BoolToInt(Value);
end;

procedure TVkGroupMemberState.SetRequest(const Value: Boolean);
begin
  FRequest := BoolToInt(Value);
end;

function TVkGroupMemberState.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

{ TVkGroupAddress }

class function TVkGroupAddress.FromJsonString(AJsonString: string): TVkGroupAddress;
begin
  result := TJson.JsonToObject<TVkGroupAddress>(AJsonString);
end;

function TVkGroupAddress.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

{ TVkGroupLink }

class function TVkGroupLink.FromJsonString(AJsonString: string): TVkGroupLink;
begin
  result := TJson.JsonToObject<TVkGroupLink>(AJsonString);
end;

function TVkGroupLink.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

{ TVkGroupAddresses }

destructor TVkGroupAddresses.Destroy;
var
  LItemsItem: TVkGroupAddress;
begin
  for LItemsItem in FItems do
    LItemsItem.Free;
  inherited;
end;

class function TVkGroupAddresses.FromJsonString(AJsonString: string): TVkGroupAddresses;
begin
  result := TJson.JsonToObject<TVkGroupAddresses>(AJsonString);
end;

function TVkGroupAddresses.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

{ TVkInvitesGroups }

destructor TVkInvitesGroups.Destroy;
var
  LItemsItem: TVkGroup;
  LItemsUser: TVkUser;
begin
  for LItemsItem in FItems do
    LItemsItem.Free;
  for LItemsItem in FGroups do
    LItemsItem.Free;
  for LItemsUser in FProfiles do
    LItemsUser.Free;

  inherited;
end;

class function TVkInvitesGroups.FromJsonString(AJsonString: string): TVkInvitesGroups;
begin
  result := TJson.JsonToObject<TVkInvitesGroups>(AJsonString);
end;

function TVkInvitesGroups.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

{ TVkGroupTag }

class function TVkGroupTag.FromJsonString(AJsonString: string): TVkGroupTag;
begin
  result := TJson.JsonToObject<TVkGroupTag>(AJsonString);
end;

function TVkGroupTag.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

{ TVkGroupTags }

destructor TVkGroupTags.Destroy;
var
  LItemsItem: TVkGroupTag;
begin
  for LItemsItem in FItems do
    LItemsItem.Free;
  inherited;
end;

class function TVkGroupTags.FromJsonString(AJsonString: string): TVkGroupTags;
begin
  result := TJson.JsonToObject<TVkGroupTags>(AJsonString);
end;

function TVkGroupTags.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

end.

