unit VK.Types;

interface

{$INCLUDE include.inc}

uses
  System.Classes, REST.Json, System.SysUtils, System.Generics.Collections, System.JSON;

type
  TVkException = Exception;

  TVkAuthException = TVkException;

  TVkParserException = TVkException;

  TVkHandlerException = TVkException;

  TVkWrongParamException = TVkException;

  TVkLongPollServerException = TVkException;

  TVkLongPollServerParseException = TVkLongPollServerException;

  TVkLongPollServerHTTPException = TVkLongPollServerException;

  TVkGroupEventsException = TVkLongPollServerException;

  TVkUserEventsException = TVkLongPollServerException;

const
  //Inner VK errors
  ERROR_VK_UNKNOWN = -1;
  ERROR_VK_NOTOKEN = -2;

  //Message Flags
  MF_UNREAD = 1;
  MF_OUTBOX = 2;
  MF_REPLIED = 4;
  MF_IMPORTANT = 8;
  MF_CHAT = 16;
  MF_FRIENDS = 32;
  MF_SPAM = 64;
  MF_DEL�T�D = 128;
  MF_FIXED = 256;
  MF_MEDIA = 512;
  MF_UNKNOWN_1 = 1024;
  MF_UNKNOWN_2 = 2048;
  MF_UNKNOWN_3 = 4096;
  MF_UNREAD_MULTICHAT = 8192;
  MF_UNKNOWN_4 = 16384;
  MF_UNKNOWN_5 = 32768;
  MF_HIDDEN = 65536;
  MF_DELETE_FOR_ALL = 131072;
  MF_NOT_DELIVERED = 262144;
  MF_UNKNOWN_6 = 524288;
  MF_UNKNOWN_7 = 1048576;
  MF_UNKNOWN_8 = 2097152;
  MF_UNKNOWN_9 = 4194304;

  //Audio Genres
  AG_NONE = 0;
  AG_ROCK = 1;
  AG_POP = 2;
  AG_RAPANDHIPHOP = 3;
  AG_EASYLISTENING = 4;
  AG_HOUSEANDDANCE = 5;
  AG_INSTRUMENTAL = 6;
  AG_METAL = 7;
  AG_ALTERNATIVE = 21;
  AG_DUBSTEP = 8;
  AG_JAZZANDBLUES = 1001;
  AG_DRUMANDBASS = 10;
  AG_TRANCE = 11;
  AG_CHANSON = 12;
  AG_ETHNIC = 13;
  AG_ACOUSTICANDVOCAL = 14;
  AG_REGGAE = 15;
  AG_CLASSICAL = 16;
  AG_INDIEPOP = 17;
  AG_SPEECH = 19;
  AG_ELECTROPOPANDDISCO = 22;
  AG_OTHER = 18;


  //Group Dialog Flags
  GR_IMPORTANT = 1;
  GR_UNANSWERED = 2;

  //Error Codes
  VK_ERROR_INVALID_TOKEN = 5;

  //
  VK_CHAT_ID_START = 2000000000;
  VK_GROUP_ID_START = 1000000000;

type
  {$IFDEF OLD_VERSION}
  TArrayOfString = array of string;
  {$ELSE}

  TArrayOfString = TArray<string>;
  {$ENDIF}

  TArrayOfStringHelper = record helper for TArrayOfString
    function ToString: string; overload; inline;
    procedure Assign(Source: TStrings); overload;
    function IsEmpty: Boolean;
  end;

  {$IFDEF OLD_VERSION}
  TArrayOfInteger = array of Integer;
  {$ELSE}

  TArrayOfInteger = TArray<Integer>;
  {$ENDIF}

  TArrayOfIntegerHelper = record helper for TArrayOfInteger
    function ToString: string; overload; inline;
    function Add(Value: Integer): Integer;
  end;

  TFields = TArrayOfString;

  TParam = TArrayOfString;

  TParamInt = TArrayOfInteger;

  TUserIds = TArrayOfInteger;

  TIds = TArrayOfInteger;

  {$IFDEF OLD_VERSION}
  TParams = array of TParam;

  TParamsInt = array of TParamInt;
  {$ELSE}

  TParams = TArray<TParam>;

  TParamsInt = TArray<TParamInt>;
  {$ENDIF}

  TParamsHelper = record helper for TParams
    function Add(Param: TParam): Integer; overload; inline;
    function Add(Key, Value: string): Integer; overload; inline;
    function Add(Key: string; Value: Integer): Integer; overload; inline;
    function Add(Key: string; Value: Extended): Integer; overload; inline;
    function Add(Key: string; Value: TDateTime): Integer; overload; inline;
    function Add(Key: string; Value: TArrayOfString): Integer; overload; inline;
    function Add(Key: string; Value: Boolean): Integer; overload; inline;
    function Add(Key: string; Value: TArrayOfInteger): Integer; overload; inline;
    function KeyExists(Key: string): Boolean; inline;
    function GetValue(Key: string): string; inline;
    function Remove(Key: string): string; inline;
  end;

  TAttachmentArray = TArrayOfString;

  //����� ���������
  TMessageFlag = (mfUNKNOWN_9, mfUNKNOWN_8, mfUNKNOWN_7, mfUNKNOWN_6, mfNotDelivered, mfDeleteForAll, mfHidden,
    mfUNKNOWN_5, mfUNKNOWN_4, mfUnreadMultichat, mfUNKNOWN_3, mfUNKNOWN_2, mfUNKNOWN_1, mfMedia, mfFixed, mfDeleted,
    mfSpam, mfFriends, mfChat, mfImportant, mfReplied, mfOutbox, mfUnread);

  TMessageFlagHelper = record helper for TMessageFlag
    function ToString: string; inline;
  end;

  TMessageFlags = set of TMessageFlag;

  TMessageFlagsHelper = record helper for TMessageFlags
    function ToString: string; overload; inline;
  end;

  {$WARNINGS OFF}
  MessageFlags = class
  public
    class function FlagDataToFlag(FlagData: Integer): TMessageFlag;
    class function Create(Data: Integer): TMessageFlags;
    class function ToString(Flags: TMessageFlags): string;
  end;
  {$WARNINGS ON}

  //����� ������

  TAudioGenre = (agNone, agRock, agPop, agRapAndHipHop, agEasyListening, agHouseAndDance, agInstrumental, agMetal,
    agAlternative, agDubstep, agJazzAndBlues, agDrumAndBass, agTrance, agChanson, agEthnic, agAcousticAndVocal, agReggae,
    agClassical, agIndiePop, agSpeech, agElectropopAndDisco, agOther);

  TAudioGenreHelper = record helper for TAudioGenre
    function ToConst: Integer;
    function ToString: string; inline;
  end;

  AudioGenre = class
    class function Create(Value: Integer): TAudioGenre;
  end;

  TVkSortIdTime = (sitIdAsc, sitIdDesc, sitTimeAsc, sitTimeDesc);

  TVkSortIdTimeHelper = record helper for TVkSortIdTime
    function ToString: string; overload; inline;
  end;

  TVkLang = (vlAuto = -1, vlRU = 0, vlUK = 1, vlBE = 2, vlEN = 3, vlES = 4, vlFI = 5, vlDE = 6, vlIT = 7);

  /// <summary>
  ///  <b>friends</b> � ����� ���������� ������ ������ � ���� ����������.
  ///  <b>unsure</b> � ����� ���������� ������������, ������� ������� ��������� ����� (���� ���������� ��������� � ������������).
  ///  <b>managers</b> � ����� ���������� ������ ������������ ���������� (�������� ��� ������� � ��������� access_token �� ����� �������������� ����������).
  /// </summary>
  TVkGroupMembersFilter = (gmfFriends, mgfUnsure, gmfManagers);

  TVkGroupMembersFilterHelper = record helper for TVkGroupMembersFilter
    function ToString: string; inline;
  end;

  TVkFollowerField = (flPhotoId, flVerified, flSex, flBirthDate, flCity, flCountry, flHomeTown, flHasPhoto, flPhoto50,
    flPhoto100, flPhoto200Orig, flPhoto200, flPhoto400Orig, flPhotoMax, flPhotoMaxOrig, flOnline, flLists, flDomain,
    flHasMobile, flContacts, flSite, flEducation, flUniversities, flSchools, flStatus, flLastSeen, flFollowersCount,
    flCommonCount, flOccupation, flNickName, flRelatives, flRelation, flPersonal, flConnections, flExports,
    flWallComments, flActivities, flInterests, flMusic, flMovies, flTV, flBooks, flGames, flAbout, flQuotes, flCanPost,
    flCanSeeAllPosts, flCanSeeAudio, flCanWritePrivateMessage, flCanSendFriendRequest, flIsFavorite, flIsHiddenFromFeed,
    flTimeZone, flScreenName, flMaidenName, flCropPhoto, flIsFriend, flFriendStatus, flCareer, flMilitary, flBlacklisted,
    flBlacklistedByMe);

  TVkFollowerFieldHelper = record helper for TVkFollowerField
    function ToString: string; inline;
  end;

  TVkFollowerFields = set of TVkFollowerField;

  TVkFollowerFieldsHelper = record helper for TVkFollowerFields
    function ToString: string; inline;
    class function All: TVkFollowerFields; static; inline;
  end;

  TVkUserField = (ufPhotoId, ufVerified, ufSex, ufBirthDate, ufCity, ufCountry, ufHomeTown, ufHasPhoto, ufPhoto50,
    ufPhoto100, ufPhoto200Orig, ufPhoto200, ufPhoto400Orig, ufPhotoMax, ufPhotoMaxOrig, ufOnline, ufDomain, ufHasMobile,
    ufContacts, ufSite, ufEducation, ufUniversities, ufSchools, ufStatus, usLastSeen, ufFollowersCount, ufCommonCount,
    ufOccupation, ufNickname, ufRelatives, ufRelation, ufPersonal, ufConnections, ufExports, ufActivities, ufInterests,
    ufMusic, ufMovies, ufTV, ufBooks, ufGames, ufAbout, ufQuotes, ufCanPost, ufCanSeeAllPosts, ufCanSeeAudio,
    ufCanWritePrivateMessage, ufCanSendFriendRequest, ufIsFavorite, ufIsHiddenFromFeed, ufTimeZone, ufScreenName,
    ufMaidenName, ufCropPhoto, ufIsFriend, ufFriendStatus, ufCareer, ufMilitary, ufBlacklisted, ufBlacklistedByMe,
    ufCanBeInvitedGroup);

  TVkUserFieldHelper = record helper for TVkUserField
    function ToString: string; inline;
  end;

  TVkUserFields = set of TVkUserField;

  TVkUserFieldsHelper = record helper for TVkUserFields
  public
    function ToString: string; inline;
    class function All: TVkUserFields; static; inline;
  end;

  TVkGroupMemberField = (mfSex, mfBdate, mfCity, mfCountry, mfPhoto50, mfPhoto100, mfPhoto200orig, mfPhoto200,
    mfPhoto400orig, mfPhotoMax, mfPhotoMaxOrig, mfOnline, mfOnlineMobile, mfLists, mfDomain, mfHasMobile, mfContacts,
    mfConnections, mfSite, mfEducation, mfUniversities, mfSchools, mfCanPost, mfCanSeeAllPosts, mfCanSeeAudio,
    mfCanWritePrivateMessage, mfStatus, mfLastSeen, mfCommonCount, mfRelation, mfRelatives);

  TVkGroupMemberFieldHelper = record helper for TVkGroupMemberField
    function ToString: string; inline;
  end;

  TVkGroupMemberFields = set of TVkGroupMemberField;

  TVkGroupMemberFieldsHelper = record helper for TVkGroupMemberFields
  public
    function ToString: string; inline;
    class function All: TVkGroupMemberFields; static; inline;
  end;

  TVkFriendField = (ffNickName, ffDomain, ffSex, ffBirthDate, ffCity, ffCountry, ffTimeZone, ffPhoto50, ffPhoto100,
    ffPhoto200, ffHasMobile, ffContacts, ffEducation, ffOnline, ffRelation, ffLastSeen, ffStatus,
    ffCanWritePrivateMessage, ffCanSeeAllPosts, ffCanPost, ffUniversities, ffCanSeeAudio);

  TVkFriendFieldHelper = record helper for TVkFriendField
    function ToString: string; inline;
  end;

  TVkFriendFields = set of TVkFriendField;

  TVkFriendFieldsHelper = record helper for TVkFriendFields
    function ToString: string; inline;
    class function All: TVkFriendFields; static; inline;
  end;

  TVkGroupField = (gfCity, gfCountry, gfPlace, gfDescription, gfWikiPage, gfMembersCount, gfCounters, gfStartDate,
    gfFinishDate, gfCanPost, gfCanSeeAllPosts, gfActivity, gfStatus, gfContacts, gfLinks, gfFixedPost, gfVerified,
    gfSite, gfCanCreateTopic, gfPhoto50);

  TVkGroupFieldHelper = record helper for TVkGroupField
    function ToString: string; inline;
  end;

  TVkGroupFields = set of TVkGroupField;

  TVkGroupFieldsHelper = record helper for TVkGroupFields
    function ToString: string; inline;
    class function All: TVkGroupFields; static; inline;
  end;

  TVkGroupAddressField = (gafTitle, gafAddress, gafAdditionalAddress, gafCountryId, gafCityId, gafMetroStationId,
    gafLatitude, gafLongitude, gafWorkInfoStatus, gafTimeOffset);

  TVkGroupAddressFieldHelper = record helper for TVkGroupAddressField
    function ToString: string; inline;
  end;

  TVkGroupAddressFields = set of TVkGroupAddressField;

  TVkGroupAddressFieldsHelper = record helper for TVkGroupAddressFields
    function ToString: string; inline;
    class function All: TVkGroupAddressFields; static; inline;
  end;

  TVkGroupAccess = (gaOpen, gaClose, gaPrivate);

  TVkGroupAccessHelper = record helper for TVkGroupAccess
    function ToConst: Integer; inline;
  end;

  TVkGroupRole = (grModerator, grEditor, grAdmin);

  TVkGroupRoleHelper = record helper for TVkGroupRole
    function ToString: string; inline;
  end;

  /// <summary>
  /// ��� ������ ������ -> VkGroupTagColors
  /// </summary>
  TVkGroupTagColor = string;

  TVkAgeLimits = (alNone = 1, al16Plus = 2, al18Plus = 3);

  TVkAgeLimitsHelper = record helper for TVkAgeLimits
    function ToConst: Integer; inline;
  end;

  TVkCurrency = (mcRUB, mcUAH, mcKZT, mcEUR, mcUSD);

  TVkMarketCurrencyHelper = record helper for TVkCurrency
    function ToConst: Integer; inline;
  end;

  TVkGroupType = (gtGroup, gtEvent, gtPublic);

  TVkGroupTypeHelper = record helper for TVkGroupType
    function ToString: string; inline;
  end;

  TVkGroupFilter = (gftAdmin, gftEditor, gftModer, gftAdvertiser, gftGroups, gftPublics, gftEvents, gftHasAddress);

  TVkGroupFilterHelper = record helper for TVkGroupFilter
    function ToString: string; inline;
  end;

  TVkGroupFilters = set of TVkGroupFilter;

  TVkGroupFiltersHelper = record helper for TVkGroupFilters
    function ToString: string; inline;
    class function All: TVkGroupFilters; static; inline;
  end;

  TVkMessageInfo = class
  private
    FTitle: string;
    FFrom: string;
    FMentions: TArray<Extended>;
  public
    property Title: string read FTitle write FTitle;
    property From: string read FFrom write FFrom;
    property Mentions: TArray<Extended> read FMentions write FMentions;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkMessageInfo;
  end;

  TVkMessageAttachmentInfo = class
    type
      TAttachInfoType = record
        Attach: string;
        AttachType: string;
        class function Create(AAttach, AAttachType: string): TAttachInfoType; static;
      end;
  private
    FFwd: string;
    FReply: string;
    FAttach1: string;
    FAttach1_type: string;
    FAttach2: string;
    FAttach2_type: string;
    FAttach3: string;
    FAttach3_type: string;
    FAttach4: string;
    FAttach4_type: string;
    FAttach5: string;
    FAttach5_type: string;
    FAttach6: string;
    FAttach6_type: string;
    FAttach7: string;
    FAttach7_type: string;
    FAttach8: string;
    FAttach8_type: string;
    FAttach9: string;
    FAttach9_type: string;
    FAttach10: string;
    FAttach10_type: string;
    function GetCount: Integer;
    function GetAttachments(Index: Integer): TAttachInfoType;
  public
    property Fwd: string read FFwd write FFwd;
    property Reply: string read FReply write FReply;
    property Attach1: string read FAttach1 write FAttach1;
    property Attach1Type: string read FAttach1_type write FAttach1_type;
    property Attach2: string read FAttach2 write FAttach2;
    property Attach2Type: string read FAttach2_type write FAttach2_type;
    property Attach3: string read FAttach3 write FAttach3;
    property Attach3Type: string read FAttach3_type write FAttach3_type;
    property Attach4: string read FAttach4 write FAttach4;
    property Attach4Type: string read FAttach4_type write FAttach4_type;
    property Attach5: string read FAttach5 write FAttach5;
    property Attach5Type: string read FAttach5_type write FAttach5_type;
    property Attach6: string read FAttach6 write FAttach6;
    property Attach6Type: string read FAttach6_type write FAttach6_type;
    property Attach7: string read FAttach7 write FAttach7;
    property Attach7Type: string read FAttach7_type write FAttach7_type;
    property Attach8: string read FAttach8 write FAttach8;
    property Attach8Type: string read FAttach8_type write FAttach8_type;
    property Attach9: string read FAttach9 write FAttach9;
    property Attach9Type: string read FAttach9_type write FAttach9_type;
    property Attach10: string read FAttach10 write FAttach10;
    property Attach10Type: string read FAttach10_type write FAttach10_type;
    property Count: Integer read GetCount;
    property Attachments[Index: Integer]: TAttachInfoType read GetAttachments;
    function ToArray: TArray<TAttachInfoType>;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVkMessageAttachmentInfo;
  end;

  //����� ��������
  TDialogFlag = (dfImportant, dfUnanswered);

  TDialogFlags = set of TDialogFlag;

  TDialogFlagsHelper = record helper for TDialogFlags
    function ToString: string; overload; inline;
  end;

  {$WARNINGS OFF}
  DialogFlags = class
    class function FlagDataToFlag(FlagData: Integer): TDialogFlag;
    class function Create(Data: Integer): TDialogFlags;
    class function ToString(Flags: TDialogFlags): string;
  end;
  {$WARNINGS ON}

  //������������� ���� ��������� � ����

  TChatChangeInfoType = (citNone, citName, citPic, citNewAdmin, citFixMessage, citJoin, citLeave, citKick, citUnadmin);

  TChatChangeInfoTypeHelper = record helper for TChatChangeInfoType
    function ToString: string; overload; inline;
  end;

  //���������
  TVkPlatform = (pfUnknown, pfMobile, pfIPhone, pfIPad, pfAndroid, pfWindowsPhone, pfWindows, pfWeb);

  //��� ����� ������
  TFlagsChangeType = (fcFlagsReplace, fcFlagsSet, fcFlagsReset);

  TMessageChangeTypeHelper = record helper for TFlagsChangeType
    function ToString: string; overload; inline;
  end;

  //���� ��������
  TVkItemType = (itPost, itComment, itPhoto, itAudio, itVideo, itNote, itMarket, itPhotoComment, itVideoComment,
    itTopicComment, itMarketComment, itSitepage, itStory);

  TVkItemTypeHelper = record helper for TVkItemType
    function ToString: string; inline;
  end;

  //���� ��������
  TVkAttachmentType = (atUnknown, atPhoto, atVideo, atAudio, atDoc, atLink, atMarket, atMarketAlbum, atWall, atWalReply,
    atSticker, atGift, atCall, atAudioMessage);

  TVkAttachmentTypeHelper = record helper for TVkAttachmentType
    function ToString: string; inline;
    class function Create(Value: string): TVkAttachmentType; static;
  end;

  TVkPeerType = (ptUnknown, ptUser, ptChat, ptGroup, ptEmail);

  TVkPeerTypeHelper = record helper for TVkPeerType
    function ToString: string; inline;
    class function Create(Value: string): TVkPeerType; static;
  end;

  TVkPostType = (ptSuggests, ptPostponed, ptOwner, ptOthers, ptAll);

  TVkPostTypeHelper = record helper for TVkPostType
    function ToString: string; inline;
  end;

  TVkNameCase = (ncNom, ncGen, ncDat, ncAcc, ncIns, ncAbl);

  TVkNameCaseHelper = record helper for TVkNameCase
    function ToString: string; inline;
  end;
  {
  ������������ � nom, ����������� � gen, ��������� � dat, ����������� � acc, ������������ � ins, ���������� � abl. �� ��������� nom.
  }

  //���

  TVkSex = (sxMale, sxFemale);

  //��������� ���� ��������
  TVkBirthDateVisibility = (dvVisible, dvDayMonOnly, dvHidden);

  //���������
  TVkRelation = (rnNone, rnNotMarried, rnHaveFriend, rnAffiance, rnMarried, rnComplicated, rnnActivelyLooking, rnInLove,
    rnCivilMarriage);
   {0 � �� �������.
    1 � �� �����/�� �������;
    2 � ���� ����/���� �������;
    3 � ���������/����������;
    4 � �����/�������;
    5 � �� ������;
    6 � � �������� ������;
    7 � ������/��������;
    8 � � ����������� �����;}


  //��������� ������� ��������� ���������

  TMessageData = record
    MessageId: Integer;
    Flags: TMessageFlags;
    PeerId: Integer;
    TimeStamp: TDateTime;
    Text: string;
    Info: TVkMessageInfo;
    RandomId: Integer;
    Attachments: TVkMessageAttachmentInfo;
  end;

  TMessageChangeData = record
    MessageId: Integer;
    Flags: TMessageFlags;
    PeerId: Integer;
    ChangeType: TFlagsChangeType;
  end;

  TDialogChangeData = record
    PeerId: Integer;
    Flags: TDialogFlags;
    ChangeType: TFlagsChangeType;
  end;

  TResponseError = record
    Code: Integer;
    Text: string;
  end;

  TResponse = record
    Success: Boolean;
    Response: string;
    JSON: string;
    Error: TResponseError;
    function GetJSONValue: TJSONValue;
    function GetJSONResponse: TJSONValue;
  end;

  TEventExtraFields = record
    PeerId: integer; // ������������� ����������. ��� ������������: id ������������. ��� ��������� ������: 2000000000 + id ������. ��� ����������: -id ���������� ���� id ���������� + 1000000000 (��� version = 0).
    TimeStamp: integer; // ����� �������� ��������� � Unixtime;
    Text: string; // ����� ���������;
    Info: TVkMessageInfo;
    Attachments: TVkMessageAttachmentInfo;
    RandomId: Integer;
  end;

  TChatTypingData = record
    UserIds: TUserIds;
    PeerId, TotalCount: Integer;
    TimeStamp: TDateTime;
  end;

  TChatRecordingData = record
    UserIds: TUserIds;
    PeerId, TotalCount: Integer;
    TimeStamp: TDateTime;
  end;

  TVkUserBlockReason = (brOther, brSpam, brInsultingParticipants, brObsceneExpressions, brOffTopic);

  TUserBlockReasonHelper = record helper for TVkUserBlockReason
    function ToString: string; overload; inline;
    function ToConst: Integer; overload; inline;
  end;

  TVkGroupJoinType = (jtUnknown, jtJoin, jtUnsure, jtAccepted, jtApproved, jtRequest);

  TGroupJoinTypeHelper = record helper for TVkGroupJoinType
    function ToString: string; overload; inline;
  end;

  GroupJoinType = class
    class function Create(Value: string): TVkGroupJoinType;
  end;

  TVkGroupLevel = (glNone, glModer, glEditor, glAdmin);

  TVkGroupLevelHelper = record helper for TVkGroupLevel
    function ToString: string; overload; inline;
  end;

  TVkCounterFilter = (cfFriends, cfMessages, cfPhotos, cfVideos, cfNotes, cfGifts, cfEvents, cfGroups, cfNotifications,
    cfSdk, cfAppRequests, cfFriendsRecommendations);

  TVkCounterFilterHelper = record helper for TVkCounterFilter
    function ToString: string; overload; inline;
  end;

  TVkCounterFilters = set of TVkCounterFilter;

  TVkCounterFiltersHelper = record helper for TVkCounterFilters
    function ToString: string; overload; inline;
  end;

  TVkInfoFilter = (ifCountry, ifHttpsRequired, ifOwnPostsDefault, ifNoWallReplies, ifIntro, ifLang);

  TVkInfoFilterHelper = record helper for TVkInfoFilter
    function ToString: string; overload; inline;
  end;

  TVkInfoFilters = set of TVkInfoFilter;

  TVkInfoFiltersHelper = record helper for TVkInfoFilters
    function ToString: string; overload; inline;
  end;

  TVkPermission = (Notify, Friends, Photos, Audio, Video, Stories, Pages, Status, Notes, Messages, Wall, Ads, Offline,
    Docs, Groups, Notifications, Stats, Email, Market, AppWidget, Manage);

  TVkPermissionHelper = record helper for TVkPermission
    function ToString: string; overload; inline;
  end;

  TVkPermissions = set of TVkPermission;

  TVkPermissionsHelper = record helper for TVkPermissions
    function ToString: string; overload; inline;
  end;

  TOnLogin = procedure(Sender: TObject) of object;

  TOnAuth = procedure(Sender: TObject; Url: string; var Token: string; var TokenExpiry: Int64; var ChangePasswordHash:
    string) of object;

  TOnConfirm = procedure(Sender: TObject; Ans: string; var Accept: Boolean) of object;

  TOnCaptcha = procedure(Sender: TObject; const CaptchaURL: string; var Answer: string) of object;

  TOnLog = procedure(Sender: TObject; const Value: string) of object;

  TOnVKError = procedure(Sender: TObject; E: Exception; Code: Integer; Text: string) of object;

  TCallMethodCallback = reference to procedure(Respone: TResponse);

  TOnLongPollServerUpdate = procedure(Sender: TObject; GroupID: string; Update: TJSONValue) of object;

  TOnNewMessage = procedure(Sender: TObject; MessageData: TMessageData) of object;

  TOnEditMessage = procedure(Sender: TObject; MessageData: TMessageData) of object;

  TOnChangeMessageFlags = procedure(Sender: TObject; MessageChangeData: TMessageChangeData) of object;

  TOnChangeDialogFlags = procedure(Sender: TObject; DialogChangeData: TDialogChangeData) of object;

  TOnUserOnline = procedure(Sender: TObject; UserId: Integer; VkPlatform: TVkPlatform; TimeStamp: TDateTime) of object;

  TOnUserOffline = procedure(Sender: TObject; UserId: Integer; InactiveUser: Boolean; TimeStamp: TDateTime) of object;

  TOnReadMessages = procedure(Sender: TObject; Incoming: Boolean; PeerId, LocalId: Integer) of object;

  TOnRecoverOrDeleteMessages = procedure(Sender: TObject; PeerId, LocalId: Integer) of object;

  TOnChatChanged = procedure(Sender: TObject; const ChatId: Integer; IsSelf: Boolean) of object;

  TOnChatChangeInfo = procedure(Sender: TObject; const PeerId: Integer; TypeId: TChatChangeInfoType; Info: Integer) of object;

  TOnUserTyping = procedure(Sender: TObject; UserId, ChatId: Integer) of object;

  TOnUserCall = procedure(Sender: TObject; UserId, CallId: Integer) of object;

  TOnCountChange = procedure(Sender: TObject; Count: Integer) of object;

  TOnNotifyChange = procedure(Sender: TObject; PeerId: Integer; Sound: Boolean; DisableUntil: Integer) of object;

  TOnUsersTyping = procedure(Sender: TObject; Data: TChatTypingData) of object;

  TOnUsersRecording = procedure(Sender: TObject; Data: TChatRecordingData) of object;

var
  VkUserActive: array[Boolean] of string = ('�����������', '������� ����');
  VkGroupLevel: array[TVkGroupLevel] of string = ('��������', '���������',
    '��������', '�������������');
  VkUserBlockReason: array[TVkUserBlockReason] of string = ('������', '����',
    '����������� ����������', '���', '��������� �� �� ����');

var
  VkMessageFlags: array[TMessageFlag] of Integer = (MF_UNKNOWN_9, MF_UNKNOWN_8,
    MF_UNKNOWN_7, MF_UNKNOWN_6, MF_NOT_DELIVERED, MF_DELETE_FOR_ALL, MF_HIDDEN,
    MF_UNKNOWN_5, MF_UNKNOWN_4, MF_UNREAD_MULTICHAT, MF_UNKNOWN_3, MF_UNKNOWN_2,
    MF_UNKNOWN_1, MF_MEDIA, MF_FIXED, MF_DEL�T�D, MF_SPAM, MF_FRIENDS, MF_CHAT,
    MF_IMPORTANT, MF_REPLIED, MF_OUTBOX, MF_UNREAD);
  VkMessageFlagTypes: array[TMessageFlag] of string = ('Unknown_9', 'Unknown_8',
    'Unknown_7', 'Unknown_6', 'NotDelivered', 'DeleteForAll', 'Hidden',
    'Unknown_5', 'Unknown_4', 'UnreadMultichat', 'Unknown_3', 'Unknown_2',
    'Unknown_1', 'Media', 'Fixed', 'Deleted', 'Spam', 'Friends', 'Chat',
    'Important', 'Replied', 'Outbox', 'Unread');
  VkAudioGenres: array[TAudioGenre] of Integer = (AG_NONE, AG_ROCK, AG_POP,
    AG_RAPANDHIPHOP, AG_EASYLISTENING, AG_HOUSEANDDANCE, AG_INSTRUMENTAL,
    AG_METAL, AG_ALTERNATIVE, AG_DUBSTEP, AG_JAZZANDBLUES, AG_DRUMANDBASS,
    AG_TRANCE, AG_CHANSON, AG_ETHNIC, AG_ACOUSTICANDVOCAL, AG_REGGAE,
    AG_CLASSICAL, AG_INDIEPOP, AG_SPEECH, AG_ELECTROPOPANDDISCO, AG_OTHER);
  VkAudioGenresStr: array[TAudioGenre] of string = ('', 'Rock', 'Pop',
    'RapAndHipHop', 'EasyListening', 'HouseAndDance', 'Instrumental', 'Metal',
    'Alternative', 'Dubstep', 'JazzAndBlues', 'DrumAndBass', 'Trance', 'Chanson',
    'Ethnic', 'AcousticAndVocal', 'Reggae', 'Classical', 'IndiePop', 'Speech',
    'ElectropopAndDisco', 'Other');
  VkDialogFlags: array[TDialogFlag] of Integer = (GR_UNANSWERED, GR_IMPORTANT);
  VkPlatforms: array[TVkPlatform] of string = ('Unknown', 'Mobile', 'iPhone',
    'iPad', 'Android', 'Windows Phone', 'Windows', 'Web');
  VkAttachmentType: array[TVkAttachmentType] of string = ('', 'photo', 'video',
    'audio', 'doc', 'link', 'market', 'market_album', 'wall', 'wall_reply',
    'sticker', 'gift', 'call', 'audio_message');
  VkPeerType: array[TVkPeerType] of string = ('', 'user', 'chat', 'group', 'email');
  VkNameCase: array[TVkNameCase] of string = ('nom', 'gen', 'dat', 'acc', 'ins', 'abl');
  VkItemType: array[TVkItemType] of string = ('post', 'comment', 'photo',
    'audio', 'video', 'note', 'market', 'photo_comment', 'video_comment',
    'topic_comment', 'market_comment', 'sitepage', 'story');
  VkGroupJoinType: array[TVkGroupJoinType] of string = ('', 'join', 'unsure',
    'accepted', 'approved', 'request');
  VkPostType: array[TVkPostType] of string = ('suggests', 'postponed', 'owner', 'others', 'all');
  VkPremissionStr: array[TVkPermission] of string = ('notify', 'friends', 'photos', 'audio',
    'video', 'stories', 'pages', 'status', 'notes', 'messages', 'wall', 'ads', 'offline',
    'docs', 'groups', 'notifications', 'stats', 'email', 'market', 'app_widget', 'manage');
  VkUserField: array[TVkUserField] of string = (
    'photo_id', 'verified', 'sex', 'bdate', 'city', 'country', 'home_town', 'has_photo', 'photo_50',
    'photo_100', 'photo_200_orig', 'photo_200', 'photo_400_orig', 'photo_max', 'photo_max_orig',
    'online', 'domain', 'has_mobile', 'contacts', 'site', 'education', 'universities', 'schools',
    'status', 'last_seen', 'followers_count', 'common_count', 'occupation', 'nickname',
    'relatives', 'relation', 'personal', 'connections', 'exports', 'activities', 'interests',
    'music', 'movies', 'tv', 'books', 'games', 'about', 'quotes', 'can_post', 'can_see_all_posts',
    'can_see_audio', 'can_write_private_message', 'can_send_friend_request', 'is_favorite',
    'is_hidden_from_feed', 'timezone', 'screen_name', 'maiden_name', 'crop_photo', 'is_friend',
    'friend_status', 'career', 'military', 'blacklisted', 'blacklisted_by_me', 'can_be_invited_group');
  VkFollowerField: array[TVkFollowerField] of string = (
    'photo_id', 'verified', 'sex', 'bdate', 'city', 'country', 'home_town', 'has_photo', 'photo_50',
    'photo_100', 'photo_200_orig', 'photo_200', 'photo_400_orig', 'photo_max', 'photo_max_orig',
    'online', 'lists', 'domain', 'has_mobile', 'contacts', 'site', 'education', 'universities',
    'schools', 'status', 'last_seen', 'followers_count', 'common_count', 'occupation', 'nickname',
    'relatives', 'relation', 'personal', 'connections', 'exports', 'wall_comments', 'activities',
    'interests', 'music', 'movies', 'tv', 'books', 'games', 'about', 'quotes', 'can_post', 'can_see_all_posts',
    'can_see_audio', 'can_write_private_message', 'can_send_friend_request', 'is_favorite',
    'is_hidden_from_feed', 'timezone', 'screen_name', 'maiden_name', 'crop_photo', 'is_friend',
    'friend_status', 'career', 'military', 'blacklisted', 'blacklisted_by_me');
  VkFriendField: array[TVkFriendField] of string = ('nickname', 'domain', 'sex', 'bdate', 'city', 'country', 'timezone',
    'photo_50', 'photo_100', 'photo_200_orig', 'has_mobile', 'contacts', 'education', 'online', 'relation', 'last_seen', 'status',
    'can_write_private_message', 'can_see_all_posts', 'can_post', 'universities', 'can_see_audio');
  VkGroupField: array[TVkGroupField] of string = ('city', 'country', 'place', 'description', 'wiki_page', 'members_count',
    'counters', 'start_date', 'finish_date', 'can_post', 'can_see_all_posts', 'activity', 'status',
    'contacts', 'links', 'fixed_post', 'verified', 'site', 'can_create_topic', 'photo_50');
  VkGroupFilter: array[TVkGroupFilter] of string = ('admin', 'editor', 'moder', 'advertiser', 'groups', 'publics',
    'events', 'hasAddress');
  VkGroupType: array[TVkGroupType] of string = ('group', 'event', 'public');
  VkGroupRole: array[TVkGroupRole] of string = ('moderator', 'editor', 'administrator');
  VkGroupMemberField: array[TVkGroupMemberField] of string = ('sex', 'bdate', 'city', 'country', 'photo_50', 'photo_100',
    'photo_200_orig', 'photo_200', 'photo_400_orig', 'photo_max',
    'photo_max_orig', 'online', 'online_mobile', 'lists', 'domain', 'has_mobile', 'contacts', 'connections', 'site', 'education',
    'universities', 'schools', 'can_post', 'can_see_all_posts', 'can_see_audio', 'can_write_private_message', 'status',
    'last_seen', 'common_count', 'relation', 'relatives');
  VkCounterFilter: array[TVkCounterFilter] of string = ('friends', 'messages', 'photos', 'videos', 'notes',
    'gifts', 'events', 'groups', 'notifications', 'sdk', 'app_requests', 'friends_recommendations');
  VkInfoFilter: array[TVkInfoFilter] of string = ('country', 'https_required', 'own_posts_default', 'no_wall_replies',
    'intro', 'lang');
  VkCurrencyId: array[TVkCurrency] of Integer = (643, 980, 398, 978, 840);
  VkGroupAddressField: array[TVkGroupAddressField] of string = ('title', 'address', 'additional_address', 'country_id',
    'city_id', 'metro_station_id', 'latitude', 'longitude', 'work_info_status', 'time_offset');
  VkGroupTagColors: array of string = ['4bb34b', '5c9ce6', 'e64646', '792ec0', '63b9ba', 'ffa000', 'ffc107', '76787a',
    '9e8d6b', '45678f', '539b9c', '454647', '7a6c4f', '6bc76b', '5181b8', 'ff5c5c', 'a162de', '7ececf', 'aaaeb3', 'bbaa84'];

function VKErrorString(ErrorCode: Integer): string;

function AddParam(var Dest: TParams; Param: TParam): Integer;

function CreateAttachment(&Type: string; OwnerId, Id: Integer; AccessKey: string = ''): string;

function AppendItemsTag(JSON: string): string;

function NormalizePeerId(Value: Integer): Integer;

function PeerIdIsChat(Value: Integer): Boolean;

function PeerIdIsUser(Value: Integer): Boolean;

function PeerIdIsGroup(Value: Integer): Boolean;

implementation

uses
  VK.CommonUtils, System.DateUtils;

function PeerIdIsChat(Value: Integer): Boolean;
begin
  Result := Value > VK_CHAT_ID_START;
end;

function PeerIdIsUser(Value: Integer): Boolean;
begin
  Result := (Value < VK_GROUP_ID_START) and (Value > 0);
end;

function PeerIdIsGroup(Value: Integer): Boolean;
begin
  Result := (Value > VK_GROUP_ID_START) and (Value < VK_CHAT_ID_START);
end;

function NormalizePeerId(Value: Integer): Integer;
begin
  if Value > VK_CHAT_ID_START then
    Exit(Value - VK_CHAT_ID_START);
  if Value > VK_GROUP_ID_START then
    Exit(-(Value - VK_GROUP_ID_START));
  Result := Value;
end;

function AppendItemsTag(JSON: string): string;
begin
  Result := '{"Items": ' + JSON + '}';
end;

function CreateAttachment(&Type: string; OwnerId, Id: Integer; AccessKey: string): string;
begin
  Result := &Type + OwnerId.ToString + '_' + Id.ToString;
  if not AccessKey.IsEmpty then
    Result := Result + '_' + AccessKey;
end;

function AddParam(var Dest: TParams; Param: TParam): Integer;
var
  i: Integer;
begin
  for i := Low(Dest) to High(Dest) do
    if Dest[i][0] = Param[0] then
    begin
      Dest[i] := Param;
      Exit(i);
    end;
  Result := Length(Dest) + 1;
  SetLength(Dest, Result);
  Dest[Result - 1] := Param;
end;

function VKErrorString(ErrorCode: Integer): string;
var
  ErrStr: string;
begin
  case ErrorCode of
    1:
      ErrStr :=
        '��������� ����������� ������.����������� ��������� ������ �����.';
    2:
      ErrStr :=
        '���������� ���������.����������� �������� ���������� � �����������https://vk.com/editapp?id={��� API_ID} ��� ������������ �������� ����� (test_mode=1)';
    3:
      ErrStr :=
        '������� ����������� �����.����������, ��������� �� ������� �������� ����������� ������:�https://vk.com/dev/methods.';
    4:
      ErrStr :=
        '�������� �������.';
    VK_ERROR_INVALID_TOKEN:
      ErrStr :=
        '����������� ������������ �� �������.����������, ��� �� ����������� ������������ �����������.';
    6:
      ErrStr :=
        '������� ����� �������� � �������.�������� ������� �������� ����� �������� ��� ����������� �����execute. ��������� �� ������������ �� ������� ������� ��. �� ��������https://vk.com/dev/api_requests.';
    7:
      ErrStr :=
        '��� ���� ��� ���������� ����� ��������.����������, �������� �� ����������� ���������� �����������. ��� ����� ������� � ������� ������account.getAppPermissions.';
    8:
      ErrStr :=
        '�������� ������.������������������� �������� ������ ������������ ���������� (��� ����� ����� �� �������� � ��������� ������).';
    9:
      ErrStr :=
        '������� ����� ���������� ��������.������ ��������� ����� ���������� ���������. ��� ����� ����������� ������ �� ������ �������������execute����JSONP.';
    10:
      ErrStr :=
        '��������� ���������� ������ �������.����������� ��������� ������ �����.';
    11:
      ErrStr :=
        '� �������� ������ ���������� ������ ���� ��������� ��� ������������ ������ ���� ���������.���������� ���������� � �����������https://vk.com/editapp?id={��� API_ID}';
    14:
      ErrStr :=
        '��������� ���� ���� � �������� (Captcha).';
    15:
      ErrStr :=
        '������ ��������.����������, ��� �� ����������� ������ ��������������, � ������ � �������� ��� �������� ������������ ���� � ������ ������ �����.';
    16:
      ErrStr :=
        '��������� ���������� �������� �� ���������HTTPS, �.�. ������������ ������� ���������, ��������� ������ ����� ���������� ����������.'#13#10 +
        '������ �������� ��������� ����� ������, � Standalone-���������� �� ������ �������������� ��������� ��������� ���� ��������� � ������������ �������account.getInfo.';
    17:
      ErrStr :=
        '��������� ��������� ������������.��������� ������� ������������� � ���������� ������������� ������������ �� ��������� �������� ��� ���������.';
    18:
      ErrStr :=
        '�������� ������� ��� �������������.��������� ������������ ���� ������� ��� �������������';
    20:
      ErrStr :=
        '������ �������� ��������� ��� �� Standalone ����������.����� ������ ��������� �������� �� ��, ��� ���� ���������� ����� ��� Standalone, ���������, ��� ��� ����������� �� �����������redirect_uri=https://oauth.vk.com/blank.html.';
    21:
      ErrStr :=
        '������ �������� ��������� ������ ��� Standalone � Open API ����������.';
    23:
      ErrStr :=
        '����� ��� ��������.���� ���������� ������ �� API, ������� �������� � ��������� ������, ����������� �����:�https://vk.com/dev/methods.';
    24:
      ErrStr :=
        '��������� ������������� �� ������� ������������.';
    27:
      ErrStr :=
        '���� ������� ���������� ��������������.';
    28:
      ErrStr :=
        '���� ������� ���������� ��������������.';
    29:
      ErrStr :=
        '��������� �������������� ����� �� ����� ��������������� �� ������������ �� ���������� ������� ��. �� �������� https://vk.com/dev/data_limits';
    30:
      ErrStr :=
        '������� �������� �������������������, ������������� � �������, ���������� � ������������ ������ �������';
    33:
      ErrStr :=
        'Not implemented yet';
    100:
      ErrStr :=
        '���� �� ����������� ���������� ��� �� ������� ��� �������.���������� ������ ��������� ���������� � �� ������ �� �������� � ��������� ������.';
    101:
      ErrStr :=
        '�������� API ID ����������.�������� ���������� � ������ ���������������� �� ��������https://vk.com/apps?act=settings�� ������� � ������� ������API_ID�(������������� ����������).';
    103:
      ErrStr :=
        'Out of limits';
    104:
      ErrStr :=
        'Not found';
    113:
      ErrStr :=
        '�������� ������������� ������������.����������, ��� �� ����������� ������ �������������. �������� ID �� ��������� ����� ����� �������utils.resolveScreenName.';
    125:
      ErrStr :=
        'Invalid group id';
    148:
      ErrStr :=
        '������������ �� ��������� ���������� � ����� ����';
    150:
      ErrStr :=
        '�������� timestamp.��������� ���������� �������� �� ������ �������utils.getServerTime.';
    200:
      ErrStr :=
        '������ � ������� ��������.����������, ��� �� ����������� ������ �������������� (��� �������������owner_id�������������, ��� ��������� � �������������), � ������ � �������������� �������� ��� �������� ������������ ���� � ������ ������ �����.';
    201:
      ErrStr :=
        '������ � ����� ��������.����������, ��� �� ����������� ������ �������������� (��� �������������owner_id�������������, ��� ��������� � �������������), � ������ � �������������� �������� ��� �������� ������������ ���� � ������ ������ �����.';
    203:
      ErrStr :=
        '������ � ������ ��������.����������, ��� ������� ������������ �������� ���������� ��� ������������� ���������� (��� �������� � ������� ����� � ������).';
    221:
      ErrStr :=
        '������������ �������� ���������� �������� ����� � ������';
    260:
      ErrStr :=
        'Access to the groups list is denied due to the user''s privacy settings';
    300:
      ErrStr :=
        '������ ����������.������ ������������ ������ ����� ������� ������ ������� �� ������� ��� ������������ ������ ������.';
    500:
      ErrStr :=
        '�������� ���������. �� ������ �������� �������� ������� � ���������� ����������.���������� ��������� ����������:�https://vk.com/editapp?id={��� API_ID}&section=payments';
    600:
      ErrStr :=
        '��� ���� �� ���������� ������ �������� � ��������� ���������.';
    603:
      ErrStr :=
        '��������� ������ ��� ������ � ��������� ���������.';
    700:
      ErrStr :=
        '���������� �������� ���������� ���������.';
    701:
      ErrStr :=
        '������������ ������ �������� � ����������.';
    702:
      ErrStr :=
        '��������� ����� �� ���������� ������������� � ����������.';
    703:
      ErrStr :=
        'You need to enable 2FA for this action';
    704:
      ErrStr :=
        '�� �� ������ ��������� ������������ �������������, ���� � ��� �� ���������� ������� ������������� �����.';
    706:
      ErrStr :=
        'Too many addresses in club';
    901:
      ErrStr :=
        '������ ������ ������ ������������ �� ����� ����������';
    909:
      ErrStr :=
        '���������� ��������������� ��������� ����� 24 �����';
    910:
      ErrStr :=
        '���������� ��������������� ���������, ��������� ��� ������� �������';
    911:
      ErrStr :=
        'Keyboard format is invalid';
    912:
      ErrStr :=
        'This is a chat bot feature, change this status in settings';
    914:
      ErrStr :=
        '��������� ������� �������';
    917:
      ErrStr :=
        '� ��� ��� ������� � ��� ������';
    920:
      ErrStr :=
        '���������� ��������������� ��������� ������ ����';
    924:
      ErrStr :=
        '���������� ������� ��������� ��� �����������';
    925:
      ErrStr :=
        'You are not admin of this chat';
    936:
      ErrStr :=
        'Contact not found';
    940:
      ErrStr :=
        'Too many posts in messages';
    945:
      ErrStr :=
        'Chat was disabled';
    946:
      ErrStr :=
        'Chat not supported';
    949:
      ErrStr :=
        'Can''t edit pinned message yet';
    1260:
      ErrStr :=
        'Invalid screen name';
    1310:
      ErrStr :=
        '������� �� �������� ��� ������������';
    1311:
      ErrStr :=
        '��������� �������� �� �������� ��� ������������';
    2000:
      ErrStr :=
        '������ �������� ������ 10 ��������';
    3300:
      ErrStr :=
        'Recaptcha needed';
    3301:
      ErrStr :=
        'Phone validation needed';
    3302:
      ErrStr :=
        'Password validation needed';
    3303:
      ErrStr :=
        'Otp app validation needed';
    3304:
      ErrStr :=
        'Email confirmation needed';
    3305:
      ErrStr :=
        'Assert votes';
  else
    ErrStr :=
      '����������� ������';
  end;

  Result := ErrStr;
end;

{ MessageFlags }

class function MessageFlags.Create(Data: Integer): TMessageFlags;
var
  i: TMessageFlag;
begin
  Result := [];
  for i := Low(VkMessageFlags) to High(VkMessageFlags) do
  begin
    if (Data - VkMessageFlags[i]) >= 0 then
    begin
      Include(Result, FlagDataToFlag(VkMessageFlags[i]));
      Data := Data - VkMessageFlags[i];
    end;
  end;
end;

class function MessageFlags.FlagDataToFlag(FlagData: Integer): TMessageFlag;
var
  i: TMessageFlag;
begin
  Result := mfChat;
  for i := Low(VkMessageFlags) to High(VkMessageFlags) do
    if VkMessageFlags[i] = FlagData then
      Exit(i);
end;

class function MessageFlags.ToString(Flags: TMessageFlags): string;
var
  Flag: TMessageFlag;
begin
  for Flag in Flags do
    Result := Result + Flag.ToString + ' ';
end;

{ TMessageChangeTypeHelper }

function TMessageChangeTypeHelper.ToString: string;
begin
  case Self of
    fcFlagsReplace:
      Result := 'Replace';
    fcFlagsSet:
      Result := 'Set';
    fcFlagsReset:
      Result := 'Reset';
  else
    Exit('');
  end;
end;

{ DialogFlags }

class function DialogFlags.Create(Data: Integer): TDialogFlags;
var
  i: Integer;
begin
  Result := [];
  for i := Ord(dfImportant) to Ord(dfUnanswered) do
  begin
    if (Data - VkDialogFlags[TDialogFlag(i)]) >= 0 then
    begin
      Include(Result, FlagDataToFlag(VkDialogFlags[TDialogFlag(i)]));
      Data := Data - VkDialogFlags[TDialogFlag(i)];
    end;
  end;
end;

class function DialogFlags.FlagDataToFlag(FlagData: Integer): TDialogFlag;
begin
  case FlagData of
    GR_IMPORTANT:
      Exit(dfImportant);
    GR_UNANSWERED:
      Exit(dfUnanswered);
  else
    Exit(dfUnanswered);
  end;
end;

class function DialogFlags.ToString(Flags: TDialogFlags): string;
var
  Flag: TDialogFlag;
begin
  for Flag in Flags do
    case Flag of
      dfImportant:
        Result := Result + 'Important ';
      dfUnanswered:
        Result := Result + 'Unanswered ';
    end;
end;

{ TMessageFlagsHelper }

function TMessageFlagsHelper.ToString: string;
begin
  Result := MessageFlags.ToString(Self);
end;

{ TDialogFlagsHelper }

function TDialogFlagsHelper.ToString: string;
begin
  Result := DialogFlags.ToString(Self);
end;

{ TChatChangeInfoTypeHelper }

function TChatChangeInfoTypeHelper.ToString: string;
begin
  case Self of
    citNone:
      Exit('');
    citName:
      Exit('���������� �������� ������');
    citPic:
      Exit('��������� ������� ������');
    citNewAdmin:
      Exit('�������� ����� �������������');
    citFixMessage:
      Exit('���������� ���������');
    citJoin:
      Exit('������������ ������������� � ������');
    citLeave:
      Exit('������������ ������� ������');
    citKick:
      Exit('������������ ��������� �� ������');
    citUnadmin:
      Exit('� ������������ ����� ����� ��������������');
  else
    Exit('');
  end;
end;

{ TArrayOfIntegerHelper }

function TArrayOfIntegerHelper.Add(Value: Integer): Integer;
begin
  Result := Length(Self) + 1;
  SetLength(Self, Result);
  Self[Result - 1] := Value;
end;

function TArrayOfIntegerHelper.ToString: string;
var
  i: Integer;
begin
  for i := Low(Self) to High(Self) do
  begin
    if i <> Low(Self) then
      Result := Result + ',';
    Result := Result + Self[i].ToString;
  end;
end;

{ TArrayOfStringHelper }

function TArrayOfStringHelper.IsEmpty: Boolean;
begin
  Result := Length(Self) = 0;
end;

function TArrayOfStringHelper.ToString: string;
var
  i: Integer;
begin
  for i := Low(Self) to High(Self) do
  begin
    if i <> Low(Self) then
      Result := Result + ',';
    Result := Result + Self[i];
  end;
end;

procedure TArrayOfStringHelper.Assign(Source: TStrings);
var
  i: Integer;
begin
  SetLength(Self, Source.Count);
  for i := 0 to Source.Count - 1 do
    Self[i] := Source[i];
end;

{ TPermissionsHelper }

{$IFDEF OLD_VERSION}

function TPermissionsHelper.ToString: string;
var
  i: Integer;
begin
  for i := Low(Self) to High(Self) do
  begin
    if i <> Low(Self) then
      Result := Result + ',';
    Result := Result + Self[i];
  end;
end;

procedure TPermissionsHelper.Assign(Source: TStrings);
var
  i: Integer;
begin
  SetLength(Self, Source.Count);
  for i := 0 to Source.Count - 1 do
  begin
    Self[i] := Source[i];
  end;
end;

{$ENDIF}

{ TParamsHelper }

function TParamsHelper.Add(Param: TParam): Integer;
begin
  Result := AddParam(Self, Param);
end;

function TParamsHelper.Add(Key, Value: string): Integer;
begin
  Result := AddParam(Self, [Key, Value]);
end;

function TParamsHelper.Add(Key: string; Value: Integer): Integer;
begin
  Result := AddParam(Self, [Key, Value.ToString]);
end;

function TParamsHelper.Add(Key: string; Value: Boolean): Integer;
begin
  Result := AddParam(Self, [Key, BoolToString(Value)]);
end;

function TParamsHelper.Add(Key: string; Value: TArrayOfInteger): Integer;
begin
  Result := AddParam(Self, [Key, Value.ToString]);
end;

function TParamsHelper.Add(Key: string; Value: TDateTime): Integer;
begin
  Result := AddParam(Self, [Key, DateTimeToUnix(Value).ToString]);
end;

function TParamsHelper.Add(Key: string; Value: Extended): Integer;
begin
  Result := AddParam(Self, [Key, Value.ToString]);
end;

function TParamsHelper.GetValue(Key: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := Low(Self) to High(Self) do
    if Self[i][0] = Key then
      Exit(Self[i][1]);
end;

function TParamsHelper.Add(Key: string; Value: TArrayOfString): Integer;
begin
  Result := AddParam(Self, [Key, Value.ToString]);
end;

function TParamsHelper.KeyExists(Key: string): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := Low(Self) to High(Self) do
    if Self[i][0] = Key then
      Exit(True);
end;

function TParamsHelper.Remove(Key: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := Low(Self) to High(Self) do
    if Self[i][0] = Key then
    begin
      Delete(Self, i, 1);
      Break;
    end;
end;

{ TMessageFlagHelper }

function TMessageFlagHelper.ToString: string;
begin
  Result := VkMessageFlagTypes[Self];
end;

{ TAudioGenreHelper }

function TAudioGenreHelper.ToConst: Integer;
begin
  Result := VkAudioGenres[Self];
end;

function TAudioGenreHelper.ToString: string;
begin
  Result := VkAudioGenresStr[Self];
end;

{ AudioGenre }

class function AudioGenre.Create(Value: Integer): TAudioGenre;
var
  i: TAudioGenre;
begin
  Result := agOther;
  for i := Low(VkAudioGenres) to High(VkAudioGenres) do
    if VkAudioGenres[i] = Value then
      Exit(i);
end;

{ TGroupJoinTypeHelper }

function TGroupJoinTypeHelper.ToString: string;
begin
 {
  join � ������������ ������� � ������ ��� ����������� (���������� �� ��������� ��������).
  unsure � ��� �����������: ������������ ������ ������� ���������, �����.
  accepted � ������������ ������ ����������� � ������ ��� �� �����������.
  approved � ������ �� ���������� � ������/����������� ���� �������� ������������� ����������.
  request � ������������ ����� ������ �� ���������� � ����������.
 }
  case Self of
    jtUnknown:
      Exit('');
    jtJoin:
      Exit('join');
    jtUnsure:
      Exit('unsure');
    jtAccepted:
      Exit('accepted');
    jtApproved:
      Exit('approved');
    jtRequest:
      Exit('request');
  else
    Exit('');
  end;
end;

{ GroupJoinType }

class function GroupJoinType.Create(Value: string): TVkGroupJoinType;
begin
  Value := LowerCase(Value);
  if Value = 'join' then
    Exit(jtJoin);
  if Value = 'unsure' then
    Exit(jtUnsure);
  if Value = 'accepted' then
    Exit(jtAccepted);
  if Value = 'approved' then
    Exit(jtApproved);
  if Value = 'request' then
    Exit(jtRequest);
  Result := jtUnknown;
end;

{ TUserBlockReasonHelper }

function TUserBlockReasonHelper.ToConst: Integer;
begin
  Result := Ord(Self);
end;

function TUserBlockReasonHelper.ToString: string;
begin
  Result := VkUserBlockReason[Self];
end;

{ TVkGroupLevelHelper }

function TVkGroupLevelHelper.ToString: string;
begin
  Result := VkGroupLevel[Self];
end;

{ TVkItemTypeHelper }

function TVkItemTypeHelper.ToString: string;
begin
  Result := VkItemType[Self];
end;

{ TVkNameCaseHelper }

function TVkNameCaseHelper.ToString: string;
begin
  Result := VkNameCase[Self];
end;

{TVkMessageInfo}

function TVkMessageInfo.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TVkMessageInfo.FromJsonString(AJsonString: string): TVkMessageInfo;
begin
  result := TJson.JsonToObject<TVkMessageInfo>(AJsonString)
end;

{ TVkMessageAttachmentInfo }

function TVkMessageAttachmentInfo.GetCount: Integer;
begin
  if FAttach1_type.IsEmpty then
    Exit(0);
  if FAttach2_type.IsEmpty then
    Exit(1);
  if FAttach3_type.IsEmpty then
    Exit(2);
  if FAttach4_type.IsEmpty then
    Exit(3);
  if FAttach5_type.IsEmpty then
    Exit(4);
  if FAttach6_type.IsEmpty then
    Exit(5);
  if FAttach7_type.IsEmpty then
    Exit(6);
  if FAttach8_type.IsEmpty then
    Exit(7);
  if FAttach9_type.IsEmpty then
    Exit(8);
  if FAttach10_type.IsEmpty then
    Exit(9);
  Result := 10;
end;

function TVkMessageAttachmentInfo.GetAttachments(Index: Integer): TAttachInfoType;
begin
  case Index of
    1:
      Result := TVkMessageAttachmentInfo.TAttachInfoType.Create(FAttach1, FAttach1_type);
    2:
      Result := TVkMessageAttachmentInfo.TAttachInfoType.Create(FAttach2, FAttach2_type);
    3:
      Result := TVkMessageAttachmentInfo.TAttachInfoType.Create(FAttach3, FAttach3_type);
    4:
      Result := TVkMessageAttachmentInfo.TAttachInfoType.Create(FAttach4, FAttach4_type);
    5:
      Result := TVkMessageAttachmentInfo.TAttachInfoType.Create(FAttach5, FAttach5_type);
    6:
      Result := TVkMessageAttachmentInfo.TAttachInfoType.Create(FAttach6, FAttach6_type);
    7:
      Result := TVkMessageAttachmentInfo.TAttachInfoType.Create(FAttach7, FAttach7_type);
    8:
      Result := TVkMessageAttachmentInfo.TAttachInfoType.Create(FAttach8, FAttach8_type);
    9:
      Result := TVkMessageAttachmentInfo.TAttachInfoType.Create(FAttach9, FAttach9_type);
    10:
      Result := TVkMessageAttachmentInfo.TAttachInfoType.Create(FAttach10,
        FAttach10_type);
  end;
end;

function TVkMessageAttachmentInfo.ToArray: TArray<TAttachInfoType>;
var
  i: Integer;
begin
  SetLength(Result, Count);
  for i := 0 to Count - 1 do
    Result[i] := Attachments[i];
end;

function TVkMessageAttachmentInfo.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(self);
end;

class function TVkMessageAttachmentInfo.FromJsonString(AJsonString: string): TVkMessageAttachmentInfo;
begin
  Result := TJson.JsonToObject<TVkMessageAttachmentInfo>(AJsonString)
end;

{ TVkMessageAttachmentInfo.TAttachInfoType }

class function TVkMessageAttachmentInfo.TAttachInfoType.Create(AAttach, AAttachType: string): TAttachInfoType;
begin
  Result.Attach := AAttach;
  Result.AttachType := AAttachType;
end;

{ TResponse }

{$WARNINGS OFF}
function TResponse.GetJSONValue: TJSONValue;
begin
  if not JSON.IsEmpty then
    Result := TJSONObject.ParseJSONValue(UTF8ToString(JSON))
  else
    Result := nil;
end;

function TResponse.GetJSONResponse: TJSONValue;
begin
  if not Response.IsEmpty then
    Result := TJSONObject.ParseJSONValue(UTF8ToString(Response))
  else
    Result := nil;
end;
{$WARNINGS ON}

{ TVkAttachmentTypeHelper }

class function TVkAttachmentTypeHelper.Create(Value: string): TVkAttachmentType;
var
  i: TVkAttachmentType;
begin
  Result := atUnknown;
  for i := Low(VkAttachmentType) to High(VkAttachmentType) do
    if VkAttachmentType[i] = Value then
      Exit(i);
end;

function TVkAttachmentTypeHelper.ToString: string;
begin
  Result := VkAttachmentType[Self];
end;

{ TVkPeerTypeHelper }

class function TVkPeerTypeHelper.Create(Value: string): TVkPeerType;
var
  i: TVkPeerType;
begin
  Result := ptUnknown;
  for i := Low(VkPeerType) to High(VkPeerType) do
    if VkPeerType[i] = Value then
      Exit(i);
end;

function TVkPeerTypeHelper.ToString: string;
begin
  Result := VkPeerType[Self];
end;

{ TVkPostTypeHelper }

function TVkPostTypeHelper.ToString: string;
begin
  Result := VKPostType[Self];
end;

{ TVkPermissionHelper }

function TVkPermissionHelper.ToString: string;
begin
  Result := VkPremissionStr[Self];
end;

{ TVkPermissionsHelper }

function TVkPermissionsHelper.ToString: string;
var
  Item: TVkPermission;
begin
  for Item in Self do
  begin
    Result := Result + Item.ToString + ',';
  end;
  Result.TrimRight([',']);
end;

{ TVkFriendFieldHelper }

function TVkFriendFieldHelper.ToString: string;
begin
  Result := VkFriendField[Self];
end;

{ TVkFriendFieldsHelper }

class function TVkFriendFieldsHelper.All: TVkFriendFields;
begin
  Result := [ffNickName, ffDomain, ffSex, ffBirthDate, ffCity, ffCountry, ffTimeZone, ffPhoto50, ffPhoto100, ffPhoto200,
    ffHasMobile, ffContacts, ffEducation, ffOnline, ffRelation, ffLastSeen, ffStatus, ffCanWritePrivateMessage,
    ffCanSeeAllPosts, ffCanPost, ffUniversities];
end;

function TVkFriendFieldsHelper.ToString: string;
var
  Item: TVkFriendField;
begin
  for Item in Self do
  begin
    Result := Result + Item.ToString + ',';
  end;
  Result.TrimRight([',']);
end;

{ TVkGroupFieldHelper }

function TVkGroupFieldHelper.ToString: string;
begin
  Result := VkGroupField[Self];
end;

{ TVkGroupFieldsHelper }

class function TVkGroupFieldsHelper.All: TVkGroupFields;
begin
  Result := [gfCity, gfCountry, gfPlace, gfDescription, gfWikiPage, gfMembersCount, gfCounters, gfStartDate,
    gfFinishDate, gfCanPost, gfCanSeeAllPosts, gfActivity, gfStatus, gfContacts, gfLinks, gfFixedPost, gfVerified,
    gfSite, gfCanCreateTopic, gfPhoto50];
end;

function TVkGroupFieldsHelper.ToString: string;
var
  Item: TVkGroupField;
begin
  for Item in Self do
  begin
    Result := Result + Item.ToString + ',';
  end;
  Result.TrimRight([',']);
end;

{ TVkUserFieldsHelper }

class function TVkUserFieldsHelper.All: TVkUserFields;
begin
  Result := [ufPhotoId, ufVerified, ufSex, ufBirthDate, ufCity, ufCountry, ufHomeTown, ufHasPhoto, ufPhoto50, ufPhoto100,
    ufPhoto200Orig, ufPhoto200, ufPhoto400Orig, ufPhotoMax, ufPhotoMaxOrig, ufOnline, ufDomain, ufHasMobile, ufContacts,
    ufSite, ufEducation, ufUniversities, ufSchools, ufStatus, usLastSeen, ufFollowersCount, ufCommonCount, ufOccupation,
    ufNickname, ufRelatives, ufRelation, ufPersonal, ufConnections, ufExports, ufActivities, ufInterests, ufMusic,
    ufMovies, ufTV, ufBooks, ufGames,
    ufAbout, ufQuotes, ufCanPost, ufCanSeeAllPosts, ufCanSeeAudio, ufCanWritePrivateMessage, ufCanSendFriendRequest, ufIsFavorite, ufIsHiddenFromFeed, ufTimeZone, ufScreenName, ufMaidenName, ufCropPhoto, ufIsFriend, ufFriendStatus, ufCareer, ufMilitary, ufBlacklisted, ufBlacklistedByMe, ufCanBeInvitedGroup];
end;

function TVkUserFieldsHelper.ToString: string;
var
  Item: TVkUserField;
begin
  for Item in Self do
  begin
    Result := Result + Item.ToString + ',';
  end;
  Result.TrimRight([',']);
end;

{ TVkUserFieldHelper }

function TVkUserFieldHelper.ToString: string;
begin
  Result := VkUserField[Self];
end;

{ TVkFollowerFieldHelper }

function TVkFollowerFieldHelper.ToString: string;
begin
  Result := VkFollowerField[Self];
end;

{ TVkFollowerFieldsHelper }

class function TVkFollowerFieldsHelper.All: TVkFollowerFields;
begin
  Result := [flPhotoId, flVerified, flSex, flBirthDate, flCity, flCountry, flHomeTown, flHasPhoto, flPhoto50, flPhoto100,
    flPhoto200Orig, flPhoto200, flPhoto400Orig, flPhotoMax, flPhotoMaxOrig, flOnline, flLists, flDomain, flHasMobile,
    flContacts, flSite, flEducation, flUniversities, flSchools, flStatus, flLastSeen, flFollowersCount, flCommonCount,
    flOccupation, flNickName, flRelatives, flRelation, flPersonal, flConnections, flExports, flWallComments,
    flActivities, flInterests, flMusic, flMovies,
    flTV, flBooks, flGames, flAbout, flQuotes, flCanPost, flCanSeeAllPosts, flCanSeeAudio, flCanWritePrivateMessage, flCanSendFriendRequest, flIsFavorite, flIsHiddenFromFeed, flTimeZone, flScreenName, flMaidenName, flCropPhoto, flIsFriend, flFriendStatus, flCareer, flMilitary, flBlacklisted, flBlacklistedByMe];
end;

function TVkFollowerFieldsHelper.ToString: string;
var
  Item: TVkFollowerField;
begin
  for Item in Self do
  begin
    Result := Result + Item.ToString + ',';
  end;
  Result.TrimRight([',']);
end;

{ TVkGroupFilterHelper }

function TVkGroupFilterHelper.ToString: string;
begin
  Result := VkGroupFilter[Self];
end;

{ TVkGroupFiltersHelper }

class function TVkGroupFiltersHelper.All: TVkGroupFilters;
begin
  Result := [gftAdmin, gftEditor, gftModer, gftAdvertiser, gftGroups, gftPublics, gftEvents, gftHasAddress];
end;

function TVkGroupFiltersHelper.ToString: string;
var
  Item: TVkGroupFilter;
begin
  for Item in Self do
  begin
    Result := Result + Item.ToString + ',';
  end;
  Result.TrimRight([',']);
end;

{ TVkGroupMemberFieldHelper }

function TVkGroupMemberFieldHelper.ToString: string;
begin
  Result := VkGroupMemberField[Self];
end;

{ TVkGroupMemberFieldsHelper }

class function TVkGroupMemberFieldsHelper.All: TVkGroupMemberFields;
begin
  Result := [mfSex, mfBdate, mfCity, mfCountry, mfPhoto50, mfPhoto100, mfPhoto200orig, mfPhoto200,
    mfPhoto400orig, mfPhotoMax, mfPhotoMaxOrig, mfOnline, mfOnlineMobile, mfLists, mfDomain, mfHasMobile, mfContacts,
    mfConnections, mfSite, mfEducation, mfUniversities, mfSchools, mfCanPost, mfCanSeeAllPosts, mfCanSeeAudio,
    mfCanWritePrivateMessage, mfStatus, mfLastSeen, mfCommonCount, mfRelation, mfRelatives];
end;

function TVkGroupMemberFieldsHelper.ToString: string;
var
  Item: TVkGroupMemberField;
begin
  for Item in Self do
  begin
    Result := Result + Item.ToString + ',';
  end;
  Result.TrimRight([',']);
end;

{ TVkGroupMembersFilterHelper }

function TVkGroupMembersFilterHelper.ToString: string;
begin
  case Self of
    gmfFriends:
      Exit('friends');
    mgfUnsure:
      Exit('unsure');
    gmfManagers:
      Exit('managers');
  else
    Result := '';
  end;
end;

{ TVkSortIdTimeHelper }

function TVkSortIdTimeHelper.ToString: string;
begin
  case Self of
    sitIdAsc:
      Exit('id_asc');
    sitIdDesc:
      Exit('id_desc');
    sitTimeAsc:
      Exit('time_asc');
    sitTimeDesc:
      Exit('time_desc');
  else
    Result := '';
  end;
end;

{ TVkCounterFilterHelper }

function TVkCounterFilterHelper.ToString: string;
begin
  Result := VkCounterFilter[Self];
end;

{ TVkCounterFiltersHelper }

function TVkCounterFiltersHelper.ToString: string;
var
  Item: TVkCounterFilter;
begin
  for Item in Self do
  begin
    Result := Result + Item.ToString + ',';
  end;
  Result.TrimRight([',']);
end;

{ TVkInfoFilterHelper }

function TVkInfoFilterHelper.ToString: string;
begin
  Result := VkInfoFilter[Self];
end;

{ TVkInfoFiltersHelper }

function TVkInfoFiltersHelper.ToString: string;
var
  Item: TVkInfoFilter;
begin
  for Item in Self do
  begin
    Result := Result + Item.ToString + ',';
  end;
  Result.TrimRight([',']);
end;

{ TVkGroupTypeHelper }

function TVkGroupTypeHelper.ToString: string;
begin
  Result := VkGroupType[Self];
end;

{ TVkGroupAccessHelper }

function TVkGroupAccessHelper.ToConst: Integer;
begin
  Result := Ord(Self);
end;

{ TVkAgeLimitsHelper }

function TVkAgeLimitsHelper.ToConst: Integer;
begin
  Result := Ord(Self);
end;

{ TVkMarketCurrencyHelper }

function TVkMarketCurrencyHelper.ToConst: Integer;
begin
  Result := VkCurrencyId[Self];
end;

{ TVkGroupRoleHelper }

function TVkGroupRoleHelper.ToString: string;
begin
  Result := VkGroupRole[Self];
end;

{ TVkGroupAddressFieldHelper }

function TVkGroupAddressFieldHelper.ToString: string;
begin
  Result := VkGroupAddressField[Self];
end;

{ TVkGroupAddressFieldsHelper }

class function TVkGroupAddressFieldsHelper.All: TVkGroupAddressFields;
begin
  Result := [gafTitle, gafAddress, gafAdditionalAddress, gafCountryId, gafCityId, gafMetroStationId,
    gafLatitude, gafLongitude, gafWorkInfoStatus, gafTimeOffset];
end;

function TVkGroupAddressFieldsHelper.ToString: string;
var
  Item: TVkGroupAddressField;
begin
  for Item in Self do
  begin
    Result := Result + Item.ToString + ',';
  end;
  Result.TrimRight([',']);
end;

end.

