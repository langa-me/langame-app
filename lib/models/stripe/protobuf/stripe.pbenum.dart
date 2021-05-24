///
//  Generated code. Do not modify.
//  source: stripe/protobuf/stripe.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class GetCreditNotesPreviewLinesRequest_GetCreditNotesPreviewLinesRequestReason extends $pb.ProtobufEnum {
  static const GetCreditNotesPreviewLinesRequest_GetCreditNotesPreviewLinesRequestReason GET_CREDIT_NOTES_PREVIEW_LINES_REQUEST_REASON_DUPLICATE = GetCreditNotesPreviewLinesRequest_GetCreditNotesPreviewLinesRequestReason._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_CREDIT_NOTES_PREVIEW_LINES_REQUEST_REASON_DUPLICATE');
  static const GetCreditNotesPreviewLinesRequest_GetCreditNotesPreviewLinesRequestReason GET_CREDIT_NOTES_PREVIEW_LINES_REQUEST_REASON_FRAUDULENT = GetCreditNotesPreviewLinesRequest_GetCreditNotesPreviewLinesRequestReason._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_CREDIT_NOTES_PREVIEW_LINES_REQUEST_REASON_FRAUDULENT');
  static const GetCreditNotesPreviewLinesRequest_GetCreditNotesPreviewLinesRequestReason GET_CREDIT_NOTES_PREVIEW_LINES_REQUEST_REASON_ORDER_CHANGE = GetCreditNotesPreviewLinesRequest_GetCreditNotesPreviewLinesRequestReason._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_CREDIT_NOTES_PREVIEW_LINES_REQUEST_REASON_ORDER_CHANGE');
  static const GetCreditNotesPreviewLinesRequest_GetCreditNotesPreviewLinesRequestReason GET_CREDIT_NOTES_PREVIEW_LINES_REQUEST_REASON_PRODUCT_UNSATISFACTORY = GetCreditNotesPreviewLinesRequest_GetCreditNotesPreviewLinesRequestReason._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_CREDIT_NOTES_PREVIEW_LINES_REQUEST_REASON_PRODUCT_UNSATISFACTORY');

  static const $core.List<GetCreditNotesPreviewLinesRequest_GetCreditNotesPreviewLinesRequestReason> values = <GetCreditNotesPreviewLinesRequest_GetCreditNotesPreviewLinesRequestReason> [
    GET_CREDIT_NOTES_PREVIEW_LINES_REQUEST_REASON_DUPLICATE,
    GET_CREDIT_NOTES_PREVIEW_LINES_REQUEST_REASON_FRAUDULENT,
    GET_CREDIT_NOTES_PREVIEW_LINES_REQUEST_REASON_ORDER_CHANGE,
    GET_CREDIT_NOTES_PREVIEW_LINES_REQUEST_REASON_PRODUCT_UNSATISFACTORY,
  ];

  static final $core.Map<$core.int, GetCreditNotesPreviewLinesRequest_GetCreditNotesPreviewLinesRequestReason> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetCreditNotesPreviewLinesRequest_GetCreditNotesPreviewLinesRequestReason? valueOf($core.int value) => _byValue[value];

  const GetCreditNotesPreviewLinesRequest_GetCreditNotesPreviewLinesRequestReason._($core.int v, $core.String n) : super(v, n);
}

class GetCreditNotesPreviewLinesRequest_LinesMessage_LinesMessageType extends $pb.ProtobufEnum {
  static const GetCreditNotesPreviewLinesRequest_LinesMessage_LinesMessageType LINES_MESSAGE_TYPE_CUSTOM_LINE_ITEM = GetCreditNotesPreviewLinesRequest_LinesMessage_LinesMessageType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LINES_MESSAGE_TYPE_CUSTOM_LINE_ITEM');
  static const GetCreditNotesPreviewLinesRequest_LinesMessage_LinesMessageType LINES_MESSAGE_TYPE_INVOICE_LINE_ITEM = GetCreditNotesPreviewLinesRequest_LinesMessage_LinesMessageType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LINES_MESSAGE_TYPE_INVOICE_LINE_ITEM');

  static const $core.List<GetCreditNotesPreviewLinesRequest_LinesMessage_LinesMessageType> values = <GetCreditNotesPreviewLinesRequest_LinesMessage_LinesMessageType> [
    LINES_MESSAGE_TYPE_CUSTOM_LINE_ITEM,
    LINES_MESSAGE_TYPE_INVOICE_LINE_ITEM,
  ];

  static final $core.Map<$core.int, GetCreditNotesPreviewLinesRequest_LinesMessage_LinesMessageType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetCreditNotesPreviewLinesRequest_LinesMessage_LinesMessageType? valueOf($core.int value) => _byValue[value];

  const GetCreditNotesPreviewLinesRequest_LinesMessage_LinesMessageType._($core.int v, $core.String n) : super(v, n);
}

class GetCreditNotesPreviewRequest_GetCreditNotesPreviewRequestReason extends $pb.ProtobufEnum {
  static const GetCreditNotesPreviewRequest_GetCreditNotesPreviewRequestReason GET_CREDIT_NOTES_PREVIEW_REQUEST_REASON_DUPLICATE = GetCreditNotesPreviewRequest_GetCreditNotesPreviewRequestReason._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_CREDIT_NOTES_PREVIEW_REQUEST_REASON_DUPLICATE');
  static const GetCreditNotesPreviewRequest_GetCreditNotesPreviewRequestReason GET_CREDIT_NOTES_PREVIEW_REQUEST_REASON_FRAUDULENT = GetCreditNotesPreviewRequest_GetCreditNotesPreviewRequestReason._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_CREDIT_NOTES_PREVIEW_REQUEST_REASON_FRAUDULENT');
  static const GetCreditNotesPreviewRequest_GetCreditNotesPreviewRequestReason GET_CREDIT_NOTES_PREVIEW_REQUEST_REASON_ORDER_CHANGE = GetCreditNotesPreviewRequest_GetCreditNotesPreviewRequestReason._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_CREDIT_NOTES_PREVIEW_REQUEST_REASON_ORDER_CHANGE');
  static const GetCreditNotesPreviewRequest_GetCreditNotesPreviewRequestReason GET_CREDIT_NOTES_PREVIEW_REQUEST_REASON_PRODUCT_UNSATISFACTORY = GetCreditNotesPreviewRequest_GetCreditNotesPreviewRequestReason._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_CREDIT_NOTES_PREVIEW_REQUEST_REASON_PRODUCT_UNSATISFACTORY');

  static const $core.List<GetCreditNotesPreviewRequest_GetCreditNotesPreviewRequestReason> values = <GetCreditNotesPreviewRequest_GetCreditNotesPreviewRequestReason> [
    GET_CREDIT_NOTES_PREVIEW_REQUEST_REASON_DUPLICATE,
    GET_CREDIT_NOTES_PREVIEW_REQUEST_REASON_FRAUDULENT,
    GET_CREDIT_NOTES_PREVIEW_REQUEST_REASON_ORDER_CHANGE,
    GET_CREDIT_NOTES_PREVIEW_REQUEST_REASON_PRODUCT_UNSATISFACTORY,
  ];

  static final $core.Map<$core.int, GetCreditNotesPreviewRequest_GetCreditNotesPreviewRequestReason> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetCreditNotesPreviewRequest_GetCreditNotesPreviewRequestReason? valueOf($core.int value) => _byValue[value];

  const GetCreditNotesPreviewRequest_GetCreditNotesPreviewRequestReason._($core.int v, $core.String n) : super(v, n);
}

class GetCreditNotesPreviewRequest_LinesMessage_LinesMessageType extends $pb.ProtobufEnum {
  static const GetCreditNotesPreviewRequest_LinesMessage_LinesMessageType LINES_MESSAGE_TYPE_CUSTOM_LINE_ITEM = GetCreditNotesPreviewRequest_LinesMessage_LinesMessageType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LINES_MESSAGE_TYPE_CUSTOM_LINE_ITEM');
  static const GetCreditNotesPreviewRequest_LinesMessage_LinesMessageType LINES_MESSAGE_TYPE_INVOICE_LINE_ITEM = GetCreditNotesPreviewRequest_LinesMessage_LinesMessageType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LINES_MESSAGE_TYPE_INVOICE_LINE_ITEM');

  static const $core.List<GetCreditNotesPreviewRequest_LinesMessage_LinesMessageType> values = <GetCreditNotesPreviewRequest_LinesMessage_LinesMessageType> [
    LINES_MESSAGE_TYPE_CUSTOM_LINE_ITEM,
    LINES_MESSAGE_TYPE_INVOICE_LINE_ITEM,
  ];

  static final $core.Map<$core.int, GetCreditNotesPreviewRequest_LinesMessage_LinesMessageType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetCreditNotesPreviewRequest_LinesMessage_LinesMessageType? valueOf($core.int value) => _byValue[value];

  const GetCreditNotesPreviewRequest_LinesMessage_LinesMessageType._($core.int v, $core.String n) : super(v, n);
}

class GetFilesRequest_GetFilesRequestPurpose extends $pb.ProtobufEnum {
  static const GetFilesRequest_GetFilesRequestPurpose GET_FILES_REQUEST_PURPOSE_ACCOUNT_REQUIREMENT = GetFilesRequest_GetFilesRequestPurpose._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_FILES_REQUEST_PURPOSE_ACCOUNT_REQUIREMENT');
  static const GetFilesRequest_GetFilesRequestPurpose GET_FILES_REQUEST_PURPOSE_ADDITIONAL_VERIFICATION = GetFilesRequest_GetFilesRequestPurpose._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_FILES_REQUEST_PURPOSE_ADDITIONAL_VERIFICATION');
  static const GetFilesRequest_GetFilesRequestPurpose GET_FILES_REQUEST_PURPOSE_BUSINESS_ICON = GetFilesRequest_GetFilesRequestPurpose._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_FILES_REQUEST_PURPOSE_BUSINESS_ICON');
  static const GetFilesRequest_GetFilesRequestPurpose GET_FILES_REQUEST_PURPOSE_BUSINESS_LOGO = GetFilesRequest_GetFilesRequestPurpose._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_FILES_REQUEST_PURPOSE_BUSINESS_LOGO');
  static const GetFilesRequest_GetFilesRequestPurpose GET_FILES_REQUEST_PURPOSE_CUSTOMER_SIGNATURE = GetFilesRequest_GetFilesRequestPurpose._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_FILES_REQUEST_PURPOSE_CUSTOMER_SIGNATURE');
  static const GetFilesRequest_GetFilesRequestPurpose GET_FILES_REQUEST_PURPOSE_DISPUTE_EVIDENCE = GetFilesRequest_GetFilesRequestPurpose._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_FILES_REQUEST_PURPOSE_DISPUTE_EVIDENCE');
  static const GetFilesRequest_GetFilesRequestPurpose GET_FILES_REQUEST_PURPOSE_DOCUMENT_PROVIDER_IDENTITY_DOCUMENT = GetFilesRequest_GetFilesRequestPurpose._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_FILES_REQUEST_PURPOSE_DOCUMENT_PROVIDER_IDENTITY_DOCUMENT');
  static const GetFilesRequest_GetFilesRequestPurpose GET_FILES_REQUEST_PURPOSE_FINANCE_REPORT_RUN = GetFilesRequest_GetFilesRequestPurpose._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_FILES_REQUEST_PURPOSE_FINANCE_REPORT_RUN');
  static const GetFilesRequest_GetFilesRequestPurpose GET_FILES_REQUEST_PURPOSE_IDENTITY_DOCUMENT = GetFilesRequest_GetFilesRequestPurpose._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_FILES_REQUEST_PURPOSE_IDENTITY_DOCUMENT');
  static const GetFilesRequest_GetFilesRequestPurpose GET_FILES_REQUEST_PURPOSE_IDENTITY_DOCUMENT_DOWNLOADABLE = GetFilesRequest_GetFilesRequestPurpose._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_FILES_REQUEST_PURPOSE_IDENTITY_DOCUMENT_DOWNLOADABLE');
  static const GetFilesRequest_GetFilesRequestPurpose GET_FILES_REQUEST_PURPOSE_PCI_DOCUMENT = GetFilesRequest_GetFilesRequestPurpose._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_FILES_REQUEST_PURPOSE_PCI_DOCUMENT');
  static const GetFilesRequest_GetFilesRequestPurpose GET_FILES_REQUEST_PURPOSE_SELFIE = GetFilesRequest_GetFilesRequestPurpose._(11, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_FILES_REQUEST_PURPOSE_SELFIE');
  static const GetFilesRequest_GetFilesRequestPurpose GET_FILES_REQUEST_PURPOSE_SIGMA_SCHEDULED_QUERY = GetFilesRequest_GetFilesRequestPurpose._(12, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_FILES_REQUEST_PURPOSE_SIGMA_SCHEDULED_QUERY');
  static const GetFilesRequest_GetFilesRequestPurpose GET_FILES_REQUEST_PURPOSE_TAX_DOCUMENT_USER_UPLOAD = GetFilesRequest_GetFilesRequestPurpose._(13, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_FILES_REQUEST_PURPOSE_TAX_DOCUMENT_USER_UPLOAD');

  static const $core.List<GetFilesRequest_GetFilesRequestPurpose> values = <GetFilesRequest_GetFilesRequestPurpose> [
    GET_FILES_REQUEST_PURPOSE_ACCOUNT_REQUIREMENT,
    GET_FILES_REQUEST_PURPOSE_ADDITIONAL_VERIFICATION,
    GET_FILES_REQUEST_PURPOSE_BUSINESS_ICON,
    GET_FILES_REQUEST_PURPOSE_BUSINESS_LOGO,
    GET_FILES_REQUEST_PURPOSE_CUSTOMER_SIGNATURE,
    GET_FILES_REQUEST_PURPOSE_DISPUTE_EVIDENCE,
    GET_FILES_REQUEST_PURPOSE_DOCUMENT_PROVIDER_IDENTITY_DOCUMENT,
    GET_FILES_REQUEST_PURPOSE_FINANCE_REPORT_RUN,
    GET_FILES_REQUEST_PURPOSE_IDENTITY_DOCUMENT,
    GET_FILES_REQUEST_PURPOSE_IDENTITY_DOCUMENT_DOWNLOADABLE,
    GET_FILES_REQUEST_PURPOSE_PCI_DOCUMENT,
    GET_FILES_REQUEST_PURPOSE_SELFIE,
    GET_FILES_REQUEST_PURPOSE_SIGMA_SCHEDULED_QUERY,
    GET_FILES_REQUEST_PURPOSE_TAX_DOCUMENT_USER_UPLOAD,
  ];

  static final $core.Map<$core.int, GetFilesRequest_GetFilesRequestPurpose> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetFilesRequest_GetFilesRequestPurpose? valueOf($core.int value) => _byValue[value];

  const GetFilesRequest_GetFilesRequestPurpose._($core.int v, $core.String n) : super(v, n);
}

class GetIdentityVerificationReportsRequest_GetIdentityVerificationReportsRequestType extends $pb.ProtobufEnum {
  static const GetIdentityVerificationReportsRequest_GetIdentityVerificationReportsRequestType GET_IDENTITY_VERIFICATION_REPORTS_REQUEST_TYPE_DOCUMENT = GetIdentityVerificationReportsRequest_GetIdentityVerificationReportsRequestType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_IDENTITY_VERIFICATION_REPORTS_REQUEST_TYPE_DOCUMENT');
  static const GetIdentityVerificationReportsRequest_GetIdentityVerificationReportsRequestType GET_IDENTITY_VERIFICATION_REPORTS_REQUEST_TYPE_ID_NUMBER = GetIdentityVerificationReportsRequest_GetIdentityVerificationReportsRequestType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_IDENTITY_VERIFICATION_REPORTS_REQUEST_TYPE_ID_NUMBER');

  static const $core.List<GetIdentityVerificationReportsRequest_GetIdentityVerificationReportsRequestType> values = <GetIdentityVerificationReportsRequest_GetIdentityVerificationReportsRequestType> [
    GET_IDENTITY_VERIFICATION_REPORTS_REQUEST_TYPE_DOCUMENT,
    GET_IDENTITY_VERIFICATION_REPORTS_REQUEST_TYPE_ID_NUMBER,
  ];

  static final $core.Map<$core.int, GetIdentityVerificationReportsRequest_GetIdentityVerificationReportsRequestType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetIdentityVerificationReportsRequest_GetIdentityVerificationReportsRequestType? valueOf($core.int value) => _byValue[value];

  const GetIdentityVerificationReportsRequest_GetIdentityVerificationReportsRequestType._($core.int v, $core.String n) : super(v, n);
}

class GetIdentityVerificationSessionsRequest_GetIdentityVerificationSessionsRequestStatus extends $pb.ProtobufEnum {
  static const GetIdentityVerificationSessionsRequest_GetIdentityVerificationSessionsRequestStatus GET_IDENTITY_VERIFICATION_SESSIONS_REQUEST_STATUS_CANCELED = GetIdentityVerificationSessionsRequest_GetIdentityVerificationSessionsRequestStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_IDENTITY_VERIFICATION_SESSIONS_REQUEST_STATUS_CANCELED');
  static const GetIdentityVerificationSessionsRequest_GetIdentityVerificationSessionsRequestStatus GET_IDENTITY_VERIFICATION_SESSIONS_REQUEST_STATUS_PROCESSING = GetIdentityVerificationSessionsRequest_GetIdentityVerificationSessionsRequestStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_IDENTITY_VERIFICATION_SESSIONS_REQUEST_STATUS_PROCESSING');
  static const GetIdentityVerificationSessionsRequest_GetIdentityVerificationSessionsRequestStatus GET_IDENTITY_VERIFICATION_SESSIONS_REQUEST_STATUS_REQUIRES_INPUT = GetIdentityVerificationSessionsRequest_GetIdentityVerificationSessionsRequestStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_IDENTITY_VERIFICATION_SESSIONS_REQUEST_STATUS_REQUIRES_INPUT');
  static const GetIdentityVerificationSessionsRequest_GetIdentityVerificationSessionsRequestStatus GET_IDENTITY_VERIFICATION_SESSIONS_REQUEST_STATUS_VERIFIED = GetIdentityVerificationSessionsRequest_GetIdentityVerificationSessionsRequestStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_IDENTITY_VERIFICATION_SESSIONS_REQUEST_STATUS_VERIFIED');

  static const $core.List<GetIdentityVerificationSessionsRequest_GetIdentityVerificationSessionsRequestStatus> values = <GetIdentityVerificationSessionsRequest_GetIdentityVerificationSessionsRequestStatus> [
    GET_IDENTITY_VERIFICATION_SESSIONS_REQUEST_STATUS_CANCELED,
    GET_IDENTITY_VERIFICATION_SESSIONS_REQUEST_STATUS_PROCESSING,
    GET_IDENTITY_VERIFICATION_SESSIONS_REQUEST_STATUS_REQUIRES_INPUT,
    GET_IDENTITY_VERIFICATION_SESSIONS_REQUEST_STATUS_VERIFIED,
  ];

  static final $core.Map<$core.int, GetIdentityVerificationSessionsRequest_GetIdentityVerificationSessionsRequestStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetIdentityVerificationSessionsRequest_GetIdentityVerificationSessionsRequestStatus? valueOf($core.int value) => _byValue[value];

  const GetIdentityVerificationSessionsRequest_GetIdentityVerificationSessionsRequestStatus._($core.int v, $core.String n) : super(v, n);
}

class GetInvoicesRequest_GetInvoicesRequestCollectionMethod extends $pb.ProtobufEnum {
  static const GetInvoicesRequest_GetInvoicesRequestCollectionMethod GET_INVOICES_REQUEST_COLLECTION_METHOD_CHARGE_AUTOMATICALLY = GetInvoicesRequest_GetInvoicesRequestCollectionMethod._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_INVOICES_REQUEST_COLLECTION_METHOD_CHARGE_AUTOMATICALLY');
  static const GetInvoicesRequest_GetInvoicesRequestCollectionMethod GET_INVOICES_REQUEST_COLLECTION_METHOD_SEND_INVOICE = GetInvoicesRequest_GetInvoicesRequestCollectionMethod._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_INVOICES_REQUEST_COLLECTION_METHOD_SEND_INVOICE');

  static const $core.List<GetInvoicesRequest_GetInvoicesRequestCollectionMethod> values = <GetInvoicesRequest_GetInvoicesRequestCollectionMethod> [
    GET_INVOICES_REQUEST_COLLECTION_METHOD_CHARGE_AUTOMATICALLY,
    GET_INVOICES_REQUEST_COLLECTION_METHOD_SEND_INVOICE,
  ];

  static final $core.Map<$core.int, GetInvoicesRequest_GetInvoicesRequestCollectionMethod> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetInvoicesRequest_GetInvoicesRequestCollectionMethod? valueOf($core.int value) => _byValue[value];

  const GetInvoicesRequest_GetInvoicesRequestCollectionMethod._($core.int v, $core.String n) : super(v, n);
}

class GetInvoicesRequest_GetInvoicesRequestStatus extends $pb.ProtobufEnum {
  static const GetInvoicesRequest_GetInvoicesRequestStatus GET_INVOICES_REQUEST_STATUS_DRAFT = GetInvoicesRequest_GetInvoicesRequestStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_INVOICES_REQUEST_STATUS_DRAFT');
  static const GetInvoicesRequest_GetInvoicesRequestStatus GET_INVOICES_REQUEST_STATUS_OPEN = GetInvoicesRequest_GetInvoicesRequestStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_INVOICES_REQUEST_STATUS_OPEN');
  static const GetInvoicesRequest_GetInvoicesRequestStatus GET_INVOICES_REQUEST_STATUS_PAID = GetInvoicesRequest_GetInvoicesRequestStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_INVOICES_REQUEST_STATUS_PAID');
  static const GetInvoicesRequest_GetInvoicesRequestStatus GET_INVOICES_REQUEST_STATUS_UNCOLLECTIBLE = GetInvoicesRequest_GetInvoicesRequestStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_INVOICES_REQUEST_STATUS_UNCOLLECTIBLE');
  static const GetInvoicesRequest_GetInvoicesRequestStatus GET_INVOICES_REQUEST_STATUS_VOID = GetInvoicesRequest_GetInvoicesRequestStatus._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_INVOICES_REQUEST_STATUS_VOID');

  static const $core.List<GetInvoicesRequest_GetInvoicesRequestStatus> values = <GetInvoicesRequest_GetInvoicesRequestStatus> [
    GET_INVOICES_REQUEST_STATUS_DRAFT,
    GET_INVOICES_REQUEST_STATUS_OPEN,
    GET_INVOICES_REQUEST_STATUS_PAID,
    GET_INVOICES_REQUEST_STATUS_UNCOLLECTIBLE,
    GET_INVOICES_REQUEST_STATUS_VOID,
  ];

  static final $core.Map<$core.int, GetInvoicesRequest_GetInvoicesRequestStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetInvoicesRequest_GetInvoicesRequestStatus? valueOf($core.int value) => _byValue[value];

  const GetInvoicesRequest_GetInvoicesRequestStatus._($core.int v, $core.String n) : super(v, n);
}

class GetInvoicesUpcomingLinesRequest_GetInvoicesUpcomingLinesRequestSubscriptionProrationBehavior extends $pb.ProtobufEnum {
  static const GetInvoicesUpcomingLinesRequest_GetInvoicesUpcomingLinesRequestSubscriptionProrationBehavior GET_INVOICES_UPCOMING_LINES_REQUEST_SUBSCRIPTION_PRORATION_BEHAVIOR_ALWAYS_INVOICE = GetInvoicesUpcomingLinesRequest_GetInvoicesUpcomingLinesRequestSubscriptionProrationBehavior._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_INVOICES_UPCOMING_LINES_REQUEST_SUBSCRIPTION_PRORATION_BEHAVIOR_ALWAYS_INVOICE');
  static const GetInvoicesUpcomingLinesRequest_GetInvoicesUpcomingLinesRequestSubscriptionProrationBehavior GET_INVOICES_UPCOMING_LINES_REQUEST_SUBSCRIPTION_PRORATION_BEHAVIOR_CREATE_PRORATIONS = GetInvoicesUpcomingLinesRequest_GetInvoicesUpcomingLinesRequestSubscriptionProrationBehavior._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_INVOICES_UPCOMING_LINES_REQUEST_SUBSCRIPTION_PRORATION_BEHAVIOR_CREATE_PRORATIONS');
  static const GetInvoicesUpcomingLinesRequest_GetInvoicesUpcomingLinesRequestSubscriptionProrationBehavior GET_INVOICES_UPCOMING_LINES_REQUEST_SUBSCRIPTION_PRORATION_BEHAVIOR_NONE = GetInvoicesUpcomingLinesRequest_GetInvoicesUpcomingLinesRequestSubscriptionProrationBehavior._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_INVOICES_UPCOMING_LINES_REQUEST_SUBSCRIPTION_PRORATION_BEHAVIOR_NONE');

  static const $core.List<GetInvoicesUpcomingLinesRequest_GetInvoicesUpcomingLinesRequestSubscriptionProrationBehavior> values = <GetInvoicesUpcomingLinesRequest_GetInvoicesUpcomingLinesRequestSubscriptionProrationBehavior> [
    GET_INVOICES_UPCOMING_LINES_REQUEST_SUBSCRIPTION_PRORATION_BEHAVIOR_ALWAYS_INVOICE,
    GET_INVOICES_UPCOMING_LINES_REQUEST_SUBSCRIPTION_PRORATION_BEHAVIOR_CREATE_PRORATIONS,
    GET_INVOICES_UPCOMING_LINES_REQUEST_SUBSCRIPTION_PRORATION_BEHAVIOR_NONE,
  ];

  static final $core.Map<$core.int, GetInvoicesUpcomingLinesRequest_GetInvoicesUpcomingLinesRequestSubscriptionProrationBehavior> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetInvoicesUpcomingLinesRequest_GetInvoicesUpcomingLinesRequestSubscriptionProrationBehavior? valueOf($core.int value) => _byValue[value];

  const GetInvoicesUpcomingLinesRequest_GetInvoicesUpcomingLinesRequestSubscriptionProrationBehavior._($core.int v, $core.String n) : super(v, n);
}

class GetInvoicesUpcomingLinesRequest_SubscriptionItemsMessage_PriceDataMessage_RecurringMessage_RecurringMessageInterval extends $pb.ProtobufEnum {
  static const GetInvoicesUpcomingLinesRequest_SubscriptionItemsMessage_PriceDataMessage_RecurringMessage_RecurringMessageInterval RECURRING_MESSAGE_INTERVAL_DAY = GetInvoicesUpcomingLinesRequest_SubscriptionItemsMessage_PriceDataMessage_RecurringMessage_RecurringMessageInterval._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RECURRING_MESSAGE_INTERVAL_DAY');
  static const GetInvoicesUpcomingLinesRequest_SubscriptionItemsMessage_PriceDataMessage_RecurringMessage_RecurringMessageInterval RECURRING_MESSAGE_INTERVAL_MONTH = GetInvoicesUpcomingLinesRequest_SubscriptionItemsMessage_PriceDataMessage_RecurringMessage_RecurringMessageInterval._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RECURRING_MESSAGE_INTERVAL_MONTH');
  static const GetInvoicesUpcomingLinesRequest_SubscriptionItemsMessage_PriceDataMessage_RecurringMessage_RecurringMessageInterval RECURRING_MESSAGE_INTERVAL_WEEK = GetInvoicesUpcomingLinesRequest_SubscriptionItemsMessage_PriceDataMessage_RecurringMessage_RecurringMessageInterval._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RECURRING_MESSAGE_INTERVAL_WEEK');
  static const GetInvoicesUpcomingLinesRequest_SubscriptionItemsMessage_PriceDataMessage_RecurringMessage_RecurringMessageInterval RECURRING_MESSAGE_INTERVAL_YEAR = GetInvoicesUpcomingLinesRequest_SubscriptionItemsMessage_PriceDataMessage_RecurringMessage_RecurringMessageInterval._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RECURRING_MESSAGE_INTERVAL_YEAR');

  static const $core.List<GetInvoicesUpcomingLinesRequest_SubscriptionItemsMessage_PriceDataMessage_RecurringMessage_RecurringMessageInterval> values = <GetInvoicesUpcomingLinesRequest_SubscriptionItemsMessage_PriceDataMessage_RecurringMessage_RecurringMessageInterval> [
    RECURRING_MESSAGE_INTERVAL_DAY,
    RECURRING_MESSAGE_INTERVAL_MONTH,
    RECURRING_MESSAGE_INTERVAL_WEEK,
    RECURRING_MESSAGE_INTERVAL_YEAR,
  ];

  static final $core.Map<$core.int, GetInvoicesUpcomingLinesRequest_SubscriptionItemsMessage_PriceDataMessage_RecurringMessage_RecurringMessageInterval> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetInvoicesUpcomingLinesRequest_SubscriptionItemsMessage_PriceDataMessage_RecurringMessage_RecurringMessageInterval? valueOf($core.int value) => _byValue[value];

  const GetInvoicesUpcomingLinesRequest_SubscriptionItemsMessage_PriceDataMessage_RecurringMessage_RecurringMessageInterval._($core.int v, $core.String n) : super(v, n);
}

class GetInvoicesUpcomingRequest_GetInvoicesUpcomingRequestSubscriptionProrationBehavior extends $pb.ProtobufEnum {
  static const GetInvoicesUpcomingRequest_GetInvoicesUpcomingRequestSubscriptionProrationBehavior GET_INVOICES_UPCOMING_REQUEST_SUBSCRIPTION_PRORATION_BEHAVIOR_ALWAYS_INVOICE = GetInvoicesUpcomingRequest_GetInvoicesUpcomingRequestSubscriptionProrationBehavior._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_INVOICES_UPCOMING_REQUEST_SUBSCRIPTION_PRORATION_BEHAVIOR_ALWAYS_INVOICE');
  static const GetInvoicesUpcomingRequest_GetInvoicesUpcomingRequestSubscriptionProrationBehavior GET_INVOICES_UPCOMING_REQUEST_SUBSCRIPTION_PRORATION_BEHAVIOR_CREATE_PRORATIONS = GetInvoicesUpcomingRequest_GetInvoicesUpcomingRequestSubscriptionProrationBehavior._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_INVOICES_UPCOMING_REQUEST_SUBSCRIPTION_PRORATION_BEHAVIOR_CREATE_PRORATIONS');
  static const GetInvoicesUpcomingRequest_GetInvoicesUpcomingRequestSubscriptionProrationBehavior GET_INVOICES_UPCOMING_REQUEST_SUBSCRIPTION_PRORATION_BEHAVIOR_NONE = GetInvoicesUpcomingRequest_GetInvoicesUpcomingRequestSubscriptionProrationBehavior._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_INVOICES_UPCOMING_REQUEST_SUBSCRIPTION_PRORATION_BEHAVIOR_NONE');

  static const $core.List<GetInvoicesUpcomingRequest_GetInvoicesUpcomingRequestSubscriptionProrationBehavior> values = <GetInvoicesUpcomingRequest_GetInvoicesUpcomingRequestSubscriptionProrationBehavior> [
    GET_INVOICES_UPCOMING_REQUEST_SUBSCRIPTION_PRORATION_BEHAVIOR_ALWAYS_INVOICE,
    GET_INVOICES_UPCOMING_REQUEST_SUBSCRIPTION_PRORATION_BEHAVIOR_CREATE_PRORATIONS,
    GET_INVOICES_UPCOMING_REQUEST_SUBSCRIPTION_PRORATION_BEHAVIOR_NONE,
  ];

  static final $core.Map<$core.int, GetInvoicesUpcomingRequest_GetInvoicesUpcomingRequestSubscriptionProrationBehavior> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetInvoicesUpcomingRequest_GetInvoicesUpcomingRequestSubscriptionProrationBehavior? valueOf($core.int value) => _byValue[value];

  const GetInvoicesUpcomingRequest_GetInvoicesUpcomingRequestSubscriptionProrationBehavior._($core.int v, $core.String n) : super(v, n);
}

class GetInvoicesUpcomingRequest_SubscriptionItemsMessage_PriceDataMessage_RecurringMessage_RecurringMessageInterval extends $pb.ProtobufEnum {
  static const GetInvoicesUpcomingRequest_SubscriptionItemsMessage_PriceDataMessage_RecurringMessage_RecurringMessageInterval RECURRING_MESSAGE_INTERVAL_DAY = GetInvoicesUpcomingRequest_SubscriptionItemsMessage_PriceDataMessage_RecurringMessage_RecurringMessageInterval._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RECURRING_MESSAGE_INTERVAL_DAY');
  static const GetInvoicesUpcomingRequest_SubscriptionItemsMessage_PriceDataMessage_RecurringMessage_RecurringMessageInterval RECURRING_MESSAGE_INTERVAL_MONTH = GetInvoicesUpcomingRequest_SubscriptionItemsMessage_PriceDataMessage_RecurringMessage_RecurringMessageInterval._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RECURRING_MESSAGE_INTERVAL_MONTH');
  static const GetInvoicesUpcomingRequest_SubscriptionItemsMessage_PriceDataMessage_RecurringMessage_RecurringMessageInterval RECURRING_MESSAGE_INTERVAL_WEEK = GetInvoicesUpcomingRequest_SubscriptionItemsMessage_PriceDataMessage_RecurringMessage_RecurringMessageInterval._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RECURRING_MESSAGE_INTERVAL_WEEK');
  static const GetInvoicesUpcomingRequest_SubscriptionItemsMessage_PriceDataMessage_RecurringMessage_RecurringMessageInterval RECURRING_MESSAGE_INTERVAL_YEAR = GetInvoicesUpcomingRequest_SubscriptionItemsMessage_PriceDataMessage_RecurringMessage_RecurringMessageInterval._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RECURRING_MESSAGE_INTERVAL_YEAR');

  static const $core.List<GetInvoicesUpcomingRequest_SubscriptionItemsMessage_PriceDataMessage_RecurringMessage_RecurringMessageInterval> values = <GetInvoicesUpcomingRequest_SubscriptionItemsMessage_PriceDataMessage_RecurringMessage_RecurringMessageInterval> [
    RECURRING_MESSAGE_INTERVAL_DAY,
    RECURRING_MESSAGE_INTERVAL_MONTH,
    RECURRING_MESSAGE_INTERVAL_WEEK,
    RECURRING_MESSAGE_INTERVAL_YEAR,
  ];

  static final $core.Map<$core.int, GetInvoicesUpcomingRequest_SubscriptionItemsMessage_PriceDataMessage_RecurringMessage_RecurringMessageInterval> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetInvoicesUpcomingRequest_SubscriptionItemsMessage_PriceDataMessage_RecurringMessage_RecurringMessageInterval? valueOf($core.int value) => _byValue[value];

  const GetInvoicesUpcomingRequest_SubscriptionItemsMessage_PriceDataMessage_RecurringMessage_RecurringMessageInterval._($core.int v, $core.String n) : super(v, n);
}

class GetIssuingAuthorizationsRequest_GetIssuingAuthorizationsRequestStatus extends $pb.ProtobufEnum {
  static const GetIssuingAuthorizationsRequest_GetIssuingAuthorizationsRequestStatus GET_ISSUING_AUTHORIZATIONS_REQUEST_STATUS_CLOSED = GetIssuingAuthorizationsRequest_GetIssuingAuthorizationsRequestStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_ISSUING_AUTHORIZATIONS_REQUEST_STATUS_CLOSED');
  static const GetIssuingAuthorizationsRequest_GetIssuingAuthorizationsRequestStatus GET_ISSUING_AUTHORIZATIONS_REQUEST_STATUS_PENDING = GetIssuingAuthorizationsRequest_GetIssuingAuthorizationsRequestStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_ISSUING_AUTHORIZATIONS_REQUEST_STATUS_PENDING');
  static const GetIssuingAuthorizationsRequest_GetIssuingAuthorizationsRequestStatus GET_ISSUING_AUTHORIZATIONS_REQUEST_STATUS_REVERSED = GetIssuingAuthorizationsRequest_GetIssuingAuthorizationsRequestStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_ISSUING_AUTHORIZATIONS_REQUEST_STATUS_REVERSED');

  static const $core.List<GetIssuingAuthorizationsRequest_GetIssuingAuthorizationsRequestStatus> values = <GetIssuingAuthorizationsRequest_GetIssuingAuthorizationsRequestStatus> [
    GET_ISSUING_AUTHORIZATIONS_REQUEST_STATUS_CLOSED,
    GET_ISSUING_AUTHORIZATIONS_REQUEST_STATUS_PENDING,
    GET_ISSUING_AUTHORIZATIONS_REQUEST_STATUS_REVERSED,
  ];

  static final $core.Map<$core.int, GetIssuingAuthorizationsRequest_GetIssuingAuthorizationsRequestStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetIssuingAuthorizationsRequest_GetIssuingAuthorizationsRequestStatus? valueOf($core.int value) => _byValue[value];

  const GetIssuingAuthorizationsRequest_GetIssuingAuthorizationsRequestStatus._($core.int v, $core.String n) : super(v, n);
}

class GetIssuingCardholdersRequest_GetIssuingCardholdersRequestStatus extends $pb.ProtobufEnum {
  static const GetIssuingCardholdersRequest_GetIssuingCardholdersRequestStatus GET_ISSUING_CARDHOLDERS_REQUEST_STATUS_ACTIVE = GetIssuingCardholdersRequest_GetIssuingCardholdersRequestStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_ISSUING_CARDHOLDERS_REQUEST_STATUS_ACTIVE');
  static const GetIssuingCardholdersRequest_GetIssuingCardholdersRequestStatus GET_ISSUING_CARDHOLDERS_REQUEST_STATUS_BLOCKED = GetIssuingCardholdersRequest_GetIssuingCardholdersRequestStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_ISSUING_CARDHOLDERS_REQUEST_STATUS_BLOCKED');
  static const GetIssuingCardholdersRequest_GetIssuingCardholdersRequestStatus GET_ISSUING_CARDHOLDERS_REQUEST_STATUS_INACTIVE = GetIssuingCardholdersRequest_GetIssuingCardholdersRequestStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_ISSUING_CARDHOLDERS_REQUEST_STATUS_INACTIVE');

  static const $core.List<GetIssuingCardholdersRequest_GetIssuingCardholdersRequestStatus> values = <GetIssuingCardholdersRequest_GetIssuingCardholdersRequestStatus> [
    GET_ISSUING_CARDHOLDERS_REQUEST_STATUS_ACTIVE,
    GET_ISSUING_CARDHOLDERS_REQUEST_STATUS_BLOCKED,
    GET_ISSUING_CARDHOLDERS_REQUEST_STATUS_INACTIVE,
  ];

  static final $core.Map<$core.int, GetIssuingCardholdersRequest_GetIssuingCardholdersRequestStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetIssuingCardholdersRequest_GetIssuingCardholdersRequestStatus? valueOf($core.int value) => _byValue[value];

  const GetIssuingCardholdersRequest_GetIssuingCardholdersRequestStatus._($core.int v, $core.String n) : super(v, n);
}

class GetIssuingCardholdersRequest_GetIssuingCardholdersRequestType extends $pb.ProtobufEnum {
  static const GetIssuingCardholdersRequest_GetIssuingCardholdersRequestType GET_ISSUING_CARDHOLDERS_REQUEST_TYPE_COMPANY = GetIssuingCardholdersRequest_GetIssuingCardholdersRequestType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_ISSUING_CARDHOLDERS_REQUEST_TYPE_COMPANY');
  static const GetIssuingCardholdersRequest_GetIssuingCardholdersRequestType GET_ISSUING_CARDHOLDERS_REQUEST_TYPE_INDIVIDUAL = GetIssuingCardholdersRequest_GetIssuingCardholdersRequestType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_ISSUING_CARDHOLDERS_REQUEST_TYPE_INDIVIDUAL');

  static const $core.List<GetIssuingCardholdersRequest_GetIssuingCardholdersRequestType> values = <GetIssuingCardholdersRequest_GetIssuingCardholdersRequestType> [
    GET_ISSUING_CARDHOLDERS_REQUEST_TYPE_COMPANY,
    GET_ISSUING_CARDHOLDERS_REQUEST_TYPE_INDIVIDUAL,
  ];

  static final $core.Map<$core.int, GetIssuingCardholdersRequest_GetIssuingCardholdersRequestType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetIssuingCardholdersRequest_GetIssuingCardholdersRequestType? valueOf($core.int value) => _byValue[value];

  const GetIssuingCardholdersRequest_GetIssuingCardholdersRequestType._($core.int v, $core.String n) : super(v, n);
}

class GetIssuingCardsRequest_GetIssuingCardsRequestStatus extends $pb.ProtobufEnum {
  static const GetIssuingCardsRequest_GetIssuingCardsRequestStatus GET_ISSUING_CARDS_REQUEST_STATUS_ACTIVE = GetIssuingCardsRequest_GetIssuingCardsRequestStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_ISSUING_CARDS_REQUEST_STATUS_ACTIVE');
  static const GetIssuingCardsRequest_GetIssuingCardsRequestStatus GET_ISSUING_CARDS_REQUEST_STATUS_CANCELED = GetIssuingCardsRequest_GetIssuingCardsRequestStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_ISSUING_CARDS_REQUEST_STATUS_CANCELED');
  static const GetIssuingCardsRequest_GetIssuingCardsRequestStatus GET_ISSUING_CARDS_REQUEST_STATUS_INACTIVE = GetIssuingCardsRequest_GetIssuingCardsRequestStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_ISSUING_CARDS_REQUEST_STATUS_INACTIVE');

  static const $core.List<GetIssuingCardsRequest_GetIssuingCardsRequestStatus> values = <GetIssuingCardsRequest_GetIssuingCardsRequestStatus> [
    GET_ISSUING_CARDS_REQUEST_STATUS_ACTIVE,
    GET_ISSUING_CARDS_REQUEST_STATUS_CANCELED,
    GET_ISSUING_CARDS_REQUEST_STATUS_INACTIVE,
  ];

  static final $core.Map<$core.int, GetIssuingCardsRequest_GetIssuingCardsRequestStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetIssuingCardsRequest_GetIssuingCardsRequestStatus? valueOf($core.int value) => _byValue[value];

  const GetIssuingCardsRequest_GetIssuingCardsRequestStatus._($core.int v, $core.String n) : super(v, n);
}

class GetIssuingCardsRequest_GetIssuingCardsRequestType extends $pb.ProtobufEnum {
  static const GetIssuingCardsRequest_GetIssuingCardsRequestType GET_ISSUING_CARDS_REQUEST_TYPE_PHYSICAL = GetIssuingCardsRequest_GetIssuingCardsRequestType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_ISSUING_CARDS_REQUEST_TYPE_PHYSICAL');
  static const GetIssuingCardsRequest_GetIssuingCardsRequestType GET_ISSUING_CARDS_REQUEST_TYPE_VIRTUAL = GetIssuingCardsRequest_GetIssuingCardsRequestType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_ISSUING_CARDS_REQUEST_TYPE_VIRTUAL');

  static const $core.List<GetIssuingCardsRequest_GetIssuingCardsRequestType> values = <GetIssuingCardsRequest_GetIssuingCardsRequestType> [
    GET_ISSUING_CARDS_REQUEST_TYPE_PHYSICAL,
    GET_ISSUING_CARDS_REQUEST_TYPE_VIRTUAL,
  ];

  static final $core.Map<$core.int, GetIssuingCardsRequest_GetIssuingCardsRequestType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetIssuingCardsRequest_GetIssuingCardsRequestType? valueOf($core.int value) => _byValue[value];

  const GetIssuingCardsRequest_GetIssuingCardsRequestType._($core.int v, $core.String n) : super(v, n);
}

class GetIssuingDisputesRequest_GetIssuingDisputesRequestStatus extends $pb.ProtobufEnum {
  static const GetIssuingDisputesRequest_GetIssuingDisputesRequestStatus GET_ISSUING_DISPUTES_REQUEST_STATUS_EXPIRED = GetIssuingDisputesRequest_GetIssuingDisputesRequestStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_ISSUING_DISPUTES_REQUEST_STATUS_EXPIRED');
  static const GetIssuingDisputesRequest_GetIssuingDisputesRequestStatus GET_ISSUING_DISPUTES_REQUEST_STATUS_LOST = GetIssuingDisputesRequest_GetIssuingDisputesRequestStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_ISSUING_DISPUTES_REQUEST_STATUS_LOST');
  static const GetIssuingDisputesRequest_GetIssuingDisputesRequestStatus GET_ISSUING_DISPUTES_REQUEST_STATUS_SUBMITTED = GetIssuingDisputesRequest_GetIssuingDisputesRequestStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_ISSUING_DISPUTES_REQUEST_STATUS_SUBMITTED');
  static const GetIssuingDisputesRequest_GetIssuingDisputesRequestStatus GET_ISSUING_DISPUTES_REQUEST_STATUS_UNSUBMITTED = GetIssuingDisputesRequest_GetIssuingDisputesRequestStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_ISSUING_DISPUTES_REQUEST_STATUS_UNSUBMITTED');
  static const GetIssuingDisputesRequest_GetIssuingDisputesRequestStatus GET_ISSUING_DISPUTES_REQUEST_STATUS_WON = GetIssuingDisputesRequest_GetIssuingDisputesRequestStatus._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_ISSUING_DISPUTES_REQUEST_STATUS_WON');

  static const $core.List<GetIssuingDisputesRequest_GetIssuingDisputesRequestStatus> values = <GetIssuingDisputesRequest_GetIssuingDisputesRequestStatus> [
    GET_ISSUING_DISPUTES_REQUEST_STATUS_EXPIRED,
    GET_ISSUING_DISPUTES_REQUEST_STATUS_LOST,
    GET_ISSUING_DISPUTES_REQUEST_STATUS_SUBMITTED,
    GET_ISSUING_DISPUTES_REQUEST_STATUS_UNSUBMITTED,
    GET_ISSUING_DISPUTES_REQUEST_STATUS_WON,
  ];

  static final $core.Map<$core.int, GetIssuingDisputesRequest_GetIssuingDisputesRequestStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetIssuingDisputesRequest_GetIssuingDisputesRequestStatus? valueOf($core.int value) => _byValue[value];

  const GetIssuingDisputesRequest_GetIssuingDisputesRequestStatus._($core.int v, $core.String n) : super(v, n);
}

class GetIssuingTransactionsRequest_GetIssuingTransactionsRequestType extends $pb.ProtobufEnum {
  static const GetIssuingTransactionsRequest_GetIssuingTransactionsRequestType GET_ISSUING_TRANSACTIONS_REQUEST_TYPE_CAPTURE = GetIssuingTransactionsRequest_GetIssuingTransactionsRequestType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_ISSUING_TRANSACTIONS_REQUEST_TYPE_CAPTURE');
  static const GetIssuingTransactionsRequest_GetIssuingTransactionsRequestType GET_ISSUING_TRANSACTIONS_REQUEST_TYPE_REFUND = GetIssuingTransactionsRequest_GetIssuingTransactionsRequestType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_ISSUING_TRANSACTIONS_REQUEST_TYPE_REFUND');

  static const $core.List<GetIssuingTransactionsRequest_GetIssuingTransactionsRequestType> values = <GetIssuingTransactionsRequest_GetIssuingTransactionsRequestType> [
    GET_ISSUING_TRANSACTIONS_REQUEST_TYPE_CAPTURE,
    GET_ISSUING_TRANSACTIONS_REQUEST_TYPE_REFUND,
  ];

  static final $core.Map<$core.int, GetIssuingTransactionsRequest_GetIssuingTransactionsRequestType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetIssuingTransactionsRequest_GetIssuingTransactionsRequestType? valueOf($core.int value) => _byValue[value];

  const GetIssuingTransactionsRequest_GetIssuingTransactionsRequestType._($core.int v, $core.String n) : super(v, n);
}

class GetPaymentMethodsRequest_GetPaymentMethodsRequestType extends $pb.ProtobufEnum {
  static const GetPaymentMethodsRequest_GetPaymentMethodsRequestType GET_PAYMENT_METHODS_REQUEST_TYPE_ACSS_DEBIT = GetPaymentMethodsRequest_GetPaymentMethodsRequestType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_PAYMENT_METHODS_REQUEST_TYPE_ACSS_DEBIT');
  static const GetPaymentMethodsRequest_GetPaymentMethodsRequestType GET_PAYMENT_METHODS_REQUEST_TYPE_AFTERPAY_CLEARPAY = GetPaymentMethodsRequest_GetPaymentMethodsRequestType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_PAYMENT_METHODS_REQUEST_TYPE_AFTERPAY_CLEARPAY');
  static const GetPaymentMethodsRequest_GetPaymentMethodsRequestType GET_PAYMENT_METHODS_REQUEST_TYPE_ALIPAY = GetPaymentMethodsRequest_GetPaymentMethodsRequestType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_PAYMENT_METHODS_REQUEST_TYPE_ALIPAY');
  static const GetPaymentMethodsRequest_GetPaymentMethodsRequestType GET_PAYMENT_METHODS_REQUEST_TYPE_AU_BECS_DEBIT = GetPaymentMethodsRequest_GetPaymentMethodsRequestType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_PAYMENT_METHODS_REQUEST_TYPE_AU_BECS_DEBIT');
  static const GetPaymentMethodsRequest_GetPaymentMethodsRequestType GET_PAYMENT_METHODS_REQUEST_TYPE_BACS_DEBIT = GetPaymentMethodsRequest_GetPaymentMethodsRequestType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_PAYMENT_METHODS_REQUEST_TYPE_BACS_DEBIT');
  static const GetPaymentMethodsRequest_GetPaymentMethodsRequestType GET_PAYMENT_METHODS_REQUEST_TYPE_BANCONTACT = GetPaymentMethodsRequest_GetPaymentMethodsRequestType._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_PAYMENT_METHODS_REQUEST_TYPE_BANCONTACT');
  static const GetPaymentMethodsRequest_GetPaymentMethodsRequestType GET_PAYMENT_METHODS_REQUEST_TYPE_CARD = GetPaymentMethodsRequest_GetPaymentMethodsRequestType._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_PAYMENT_METHODS_REQUEST_TYPE_CARD');
  static const GetPaymentMethodsRequest_GetPaymentMethodsRequestType GET_PAYMENT_METHODS_REQUEST_TYPE_EPS = GetPaymentMethodsRequest_GetPaymentMethodsRequestType._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_PAYMENT_METHODS_REQUEST_TYPE_EPS');
  static const GetPaymentMethodsRequest_GetPaymentMethodsRequestType GET_PAYMENT_METHODS_REQUEST_TYPE_FPX = GetPaymentMethodsRequest_GetPaymentMethodsRequestType._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_PAYMENT_METHODS_REQUEST_TYPE_FPX');
  static const GetPaymentMethodsRequest_GetPaymentMethodsRequestType GET_PAYMENT_METHODS_REQUEST_TYPE_GIROPAY = GetPaymentMethodsRequest_GetPaymentMethodsRequestType._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_PAYMENT_METHODS_REQUEST_TYPE_GIROPAY');
  static const GetPaymentMethodsRequest_GetPaymentMethodsRequestType GET_PAYMENT_METHODS_REQUEST_TYPE_GRABPAY = GetPaymentMethodsRequest_GetPaymentMethodsRequestType._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_PAYMENT_METHODS_REQUEST_TYPE_GRABPAY');
  static const GetPaymentMethodsRequest_GetPaymentMethodsRequestType GET_PAYMENT_METHODS_REQUEST_TYPE_IDEAL = GetPaymentMethodsRequest_GetPaymentMethodsRequestType._(11, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_PAYMENT_METHODS_REQUEST_TYPE_IDEAL');
  static const GetPaymentMethodsRequest_GetPaymentMethodsRequestType GET_PAYMENT_METHODS_REQUEST_TYPE_OXXO = GetPaymentMethodsRequest_GetPaymentMethodsRequestType._(12, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_PAYMENT_METHODS_REQUEST_TYPE_OXXO');
  static const GetPaymentMethodsRequest_GetPaymentMethodsRequestType GET_PAYMENT_METHODS_REQUEST_TYPE_P24 = GetPaymentMethodsRequest_GetPaymentMethodsRequestType._(13, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_PAYMENT_METHODS_REQUEST_TYPE_P24');
  static const GetPaymentMethodsRequest_GetPaymentMethodsRequestType GET_PAYMENT_METHODS_REQUEST_TYPE_SEPA_DEBIT = GetPaymentMethodsRequest_GetPaymentMethodsRequestType._(14, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_PAYMENT_METHODS_REQUEST_TYPE_SEPA_DEBIT');
  static const GetPaymentMethodsRequest_GetPaymentMethodsRequestType GET_PAYMENT_METHODS_REQUEST_TYPE_SOFORT = GetPaymentMethodsRequest_GetPaymentMethodsRequestType._(15, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_PAYMENT_METHODS_REQUEST_TYPE_SOFORT');

  static const $core.List<GetPaymentMethodsRequest_GetPaymentMethodsRequestType> values = <GetPaymentMethodsRequest_GetPaymentMethodsRequestType> [
    GET_PAYMENT_METHODS_REQUEST_TYPE_ACSS_DEBIT,
    GET_PAYMENT_METHODS_REQUEST_TYPE_AFTERPAY_CLEARPAY,
    GET_PAYMENT_METHODS_REQUEST_TYPE_ALIPAY,
    GET_PAYMENT_METHODS_REQUEST_TYPE_AU_BECS_DEBIT,
    GET_PAYMENT_METHODS_REQUEST_TYPE_BACS_DEBIT,
    GET_PAYMENT_METHODS_REQUEST_TYPE_BANCONTACT,
    GET_PAYMENT_METHODS_REQUEST_TYPE_CARD,
    GET_PAYMENT_METHODS_REQUEST_TYPE_EPS,
    GET_PAYMENT_METHODS_REQUEST_TYPE_FPX,
    GET_PAYMENT_METHODS_REQUEST_TYPE_GIROPAY,
    GET_PAYMENT_METHODS_REQUEST_TYPE_GRABPAY,
    GET_PAYMENT_METHODS_REQUEST_TYPE_IDEAL,
    GET_PAYMENT_METHODS_REQUEST_TYPE_OXXO,
    GET_PAYMENT_METHODS_REQUEST_TYPE_P24,
    GET_PAYMENT_METHODS_REQUEST_TYPE_SEPA_DEBIT,
    GET_PAYMENT_METHODS_REQUEST_TYPE_SOFORT,
  ];

  static final $core.Map<$core.int, GetPaymentMethodsRequest_GetPaymentMethodsRequestType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetPaymentMethodsRequest_GetPaymentMethodsRequestType? valueOf($core.int value) => _byValue[value];

  const GetPaymentMethodsRequest_GetPaymentMethodsRequestType._($core.int v, $core.String n) : super(v, n);
}

class GetPricesRequest_GetPricesRequestType extends $pb.ProtobufEnum {
  static const GetPricesRequest_GetPricesRequestType GET_PRICES_REQUEST_TYPE_ONE_TIME = GetPricesRequest_GetPricesRequestType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_PRICES_REQUEST_TYPE_ONE_TIME');
  static const GetPricesRequest_GetPricesRequestType GET_PRICES_REQUEST_TYPE_RECURRING = GetPricesRequest_GetPricesRequestType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_PRICES_REQUEST_TYPE_RECURRING');

  static const $core.List<GetPricesRequest_GetPricesRequestType> values = <GetPricesRequest_GetPricesRequestType> [
    GET_PRICES_REQUEST_TYPE_ONE_TIME,
    GET_PRICES_REQUEST_TYPE_RECURRING,
  ];

  static final $core.Map<$core.int, GetPricesRequest_GetPricesRequestType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetPricesRequest_GetPricesRequestType? valueOf($core.int value) => _byValue[value];

  const GetPricesRequest_GetPricesRequestType._($core.int v, $core.String n) : super(v, n);
}

class GetPricesRequest_RecurringMessage_RecurringMessageInterval extends $pb.ProtobufEnum {
  static const GetPricesRequest_RecurringMessage_RecurringMessageInterval RECURRING_MESSAGE_INTERVAL_DAY = GetPricesRequest_RecurringMessage_RecurringMessageInterval._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RECURRING_MESSAGE_INTERVAL_DAY');
  static const GetPricesRequest_RecurringMessage_RecurringMessageInterval RECURRING_MESSAGE_INTERVAL_MONTH = GetPricesRequest_RecurringMessage_RecurringMessageInterval._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RECURRING_MESSAGE_INTERVAL_MONTH');
  static const GetPricesRequest_RecurringMessage_RecurringMessageInterval RECURRING_MESSAGE_INTERVAL_WEEK = GetPricesRequest_RecurringMessage_RecurringMessageInterval._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RECURRING_MESSAGE_INTERVAL_WEEK');
  static const GetPricesRequest_RecurringMessage_RecurringMessageInterval RECURRING_MESSAGE_INTERVAL_YEAR = GetPricesRequest_RecurringMessage_RecurringMessageInterval._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RECURRING_MESSAGE_INTERVAL_YEAR');

  static const $core.List<GetPricesRequest_RecurringMessage_RecurringMessageInterval> values = <GetPricesRequest_RecurringMessage_RecurringMessageInterval> [
    RECURRING_MESSAGE_INTERVAL_DAY,
    RECURRING_MESSAGE_INTERVAL_MONTH,
    RECURRING_MESSAGE_INTERVAL_WEEK,
    RECURRING_MESSAGE_INTERVAL_YEAR,
  ];

  static final $core.Map<$core.int, GetPricesRequest_RecurringMessage_RecurringMessageInterval> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetPricesRequest_RecurringMessage_RecurringMessageInterval? valueOf($core.int value) => _byValue[value];

  const GetPricesRequest_RecurringMessage_RecurringMessageInterval._($core.int v, $core.String n) : super(v, n);
}

class GetPricesRequest_RecurringMessage_RecurringMessageUsageType extends $pb.ProtobufEnum {
  static const GetPricesRequest_RecurringMessage_RecurringMessageUsageType RECURRING_MESSAGE_USAGE_TYPE_LICENSED = GetPricesRequest_RecurringMessage_RecurringMessageUsageType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RECURRING_MESSAGE_USAGE_TYPE_LICENSED');
  static const GetPricesRequest_RecurringMessage_RecurringMessageUsageType RECURRING_MESSAGE_USAGE_TYPE_METERED = GetPricesRequest_RecurringMessage_RecurringMessageUsageType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RECURRING_MESSAGE_USAGE_TYPE_METERED');

  static const $core.List<GetPricesRequest_RecurringMessage_RecurringMessageUsageType> values = <GetPricesRequest_RecurringMessage_RecurringMessageUsageType> [
    RECURRING_MESSAGE_USAGE_TYPE_LICENSED,
    RECURRING_MESSAGE_USAGE_TYPE_METERED,
  ];

  static final $core.Map<$core.int, GetPricesRequest_RecurringMessage_RecurringMessageUsageType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetPricesRequest_RecurringMessage_RecurringMessageUsageType? valueOf($core.int value) => _byValue[value];

  const GetPricesRequest_RecurringMessage_RecurringMessageUsageType._($core.int v, $core.String n) : super(v, n);
}

class GetRecipientsRequest_GetRecipientsRequestType extends $pb.ProtobufEnum {
  static const GetRecipientsRequest_GetRecipientsRequestType GET_RECIPIENTS_REQUEST_TYPE_CORPORATION = GetRecipientsRequest_GetRecipientsRequestType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_RECIPIENTS_REQUEST_TYPE_CORPORATION');
  static const GetRecipientsRequest_GetRecipientsRequestType GET_RECIPIENTS_REQUEST_TYPE_INDIVIDUAL = GetRecipientsRequest_GetRecipientsRequestType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_RECIPIENTS_REQUEST_TYPE_INDIVIDUAL');

  static const $core.List<GetRecipientsRequest_GetRecipientsRequestType> values = <GetRecipientsRequest_GetRecipientsRequestType> [
    GET_RECIPIENTS_REQUEST_TYPE_CORPORATION,
    GET_RECIPIENTS_REQUEST_TYPE_INDIVIDUAL,
  ];

  static final $core.Map<$core.int, GetRecipientsRequest_GetRecipientsRequestType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetRecipientsRequest_GetRecipientsRequestType? valueOf($core.int value) => _byValue[value];

  const GetRecipientsRequest_GetRecipientsRequestType._($core.int v, $core.String n) : super(v, n);
}

class GetSubscriptionsRequest_GetSubscriptionsRequestCollectionMethod extends $pb.ProtobufEnum {
  static const GetSubscriptionsRequest_GetSubscriptionsRequestCollectionMethod GET_SUBSCRIPTIONS_REQUEST_COLLECTION_METHOD_CHARGE_AUTOMATICALLY = GetSubscriptionsRequest_GetSubscriptionsRequestCollectionMethod._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_SUBSCRIPTIONS_REQUEST_COLLECTION_METHOD_CHARGE_AUTOMATICALLY');
  static const GetSubscriptionsRequest_GetSubscriptionsRequestCollectionMethod GET_SUBSCRIPTIONS_REQUEST_COLLECTION_METHOD_SEND_INVOICE = GetSubscriptionsRequest_GetSubscriptionsRequestCollectionMethod._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_SUBSCRIPTIONS_REQUEST_COLLECTION_METHOD_SEND_INVOICE');

  static const $core.List<GetSubscriptionsRequest_GetSubscriptionsRequestCollectionMethod> values = <GetSubscriptionsRequest_GetSubscriptionsRequestCollectionMethod> [
    GET_SUBSCRIPTIONS_REQUEST_COLLECTION_METHOD_CHARGE_AUTOMATICALLY,
    GET_SUBSCRIPTIONS_REQUEST_COLLECTION_METHOD_SEND_INVOICE,
  ];

  static final $core.Map<$core.int, GetSubscriptionsRequest_GetSubscriptionsRequestCollectionMethod> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetSubscriptionsRequest_GetSubscriptionsRequestCollectionMethod? valueOf($core.int value) => _byValue[value];

  const GetSubscriptionsRequest_GetSubscriptionsRequestCollectionMethod._($core.int v, $core.String n) : super(v, n);
}

class GetSubscriptionsRequest_GetSubscriptionsRequestStatus extends $pb.ProtobufEnum {
  static const GetSubscriptionsRequest_GetSubscriptionsRequestStatus GET_SUBSCRIPTIONS_REQUEST_STATUS_ACTIVE = GetSubscriptionsRequest_GetSubscriptionsRequestStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_SUBSCRIPTIONS_REQUEST_STATUS_ACTIVE');
  static const GetSubscriptionsRequest_GetSubscriptionsRequestStatus GET_SUBSCRIPTIONS_REQUEST_STATUS_ALL = GetSubscriptionsRequest_GetSubscriptionsRequestStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_SUBSCRIPTIONS_REQUEST_STATUS_ALL');
  static const GetSubscriptionsRequest_GetSubscriptionsRequestStatus GET_SUBSCRIPTIONS_REQUEST_STATUS_CANCELED = GetSubscriptionsRequest_GetSubscriptionsRequestStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_SUBSCRIPTIONS_REQUEST_STATUS_CANCELED');
  static const GetSubscriptionsRequest_GetSubscriptionsRequestStatus GET_SUBSCRIPTIONS_REQUEST_STATUS_ENDED = GetSubscriptionsRequest_GetSubscriptionsRequestStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_SUBSCRIPTIONS_REQUEST_STATUS_ENDED');
  static const GetSubscriptionsRequest_GetSubscriptionsRequestStatus GET_SUBSCRIPTIONS_REQUEST_STATUS_INCOMPLETE = GetSubscriptionsRequest_GetSubscriptionsRequestStatus._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_SUBSCRIPTIONS_REQUEST_STATUS_INCOMPLETE');
  static const GetSubscriptionsRequest_GetSubscriptionsRequestStatus GET_SUBSCRIPTIONS_REQUEST_STATUS_INCOMPLETE_EXPIRED = GetSubscriptionsRequest_GetSubscriptionsRequestStatus._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_SUBSCRIPTIONS_REQUEST_STATUS_INCOMPLETE_EXPIRED');
  static const GetSubscriptionsRequest_GetSubscriptionsRequestStatus GET_SUBSCRIPTIONS_REQUEST_STATUS_PAST_DUE = GetSubscriptionsRequest_GetSubscriptionsRequestStatus._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_SUBSCRIPTIONS_REQUEST_STATUS_PAST_DUE');
  static const GetSubscriptionsRequest_GetSubscriptionsRequestStatus GET_SUBSCRIPTIONS_REQUEST_STATUS_TRIALING = GetSubscriptionsRequest_GetSubscriptionsRequestStatus._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_SUBSCRIPTIONS_REQUEST_STATUS_TRIALING');
  static const GetSubscriptionsRequest_GetSubscriptionsRequestStatus GET_SUBSCRIPTIONS_REQUEST_STATUS_UNPAID = GetSubscriptionsRequest_GetSubscriptionsRequestStatus._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_SUBSCRIPTIONS_REQUEST_STATUS_UNPAID');

  static const $core.List<GetSubscriptionsRequest_GetSubscriptionsRequestStatus> values = <GetSubscriptionsRequest_GetSubscriptionsRequestStatus> [
    GET_SUBSCRIPTIONS_REQUEST_STATUS_ACTIVE,
    GET_SUBSCRIPTIONS_REQUEST_STATUS_ALL,
    GET_SUBSCRIPTIONS_REQUEST_STATUS_CANCELED,
    GET_SUBSCRIPTIONS_REQUEST_STATUS_ENDED,
    GET_SUBSCRIPTIONS_REQUEST_STATUS_INCOMPLETE,
    GET_SUBSCRIPTIONS_REQUEST_STATUS_INCOMPLETE_EXPIRED,
    GET_SUBSCRIPTIONS_REQUEST_STATUS_PAST_DUE,
    GET_SUBSCRIPTIONS_REQUEST_STATUS_TRIALING,
    GET_SUBSCRIPTIONS_REQUEST_STATUS_UNPAID,
  ];

  static final $core.Map<$core.int, GetSubscriptionsRequest_GetSubscriptionsRequestStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetSubscriptionsRequest_GetSubscriptionsRequestStatus? valueOf($core.int value) => _byValue[value];

  const GetSubscriptionsRequest_GetSubscriptionsRequestStatus._($core.int v, $core.String n) : super(v, n);
}

class GetTerminalReadersRequest_GetTerminalReadersRequestDeviceType extends $pb.ProtobufEnum {
  static const GetTerminalReadersRequest_GetTerminalReadersRequestDeviceType GET_TERMINAL_READERS_REQUEST_DEVICE_TYPE_BBPOS_CHIPPER2X = GetTerminalReadersRequest_GetTerminalReadersRequestDeviceType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_TERMINAL_READERS_REQUEST_DEVICE_TYPE_BBPOS_CHIPPER2X');
  static const GetTerminalReadersRequest_GetTerminalReadersRequestDeviceType GET_TERMINAL_READERS_REQUEST_DEVICE_TYPE_VERIFONE_P400 = GetTerminalReadersRequest_GetTerminalReadersRequestDeviceType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_TERMINAL_READERS_REQUEST_DEVICE_TYPE_VERIFONE_P400');

  static const $core.List<GetTerminalReadersRequest_GetTerminalReadersRequestDeviceType> values = <GetTerminalReadersRequest_GetTerminalReadersRequestDeviceType> [
    GET_TERMINAL_READERS_REQUEST_DEVICE_TYPE_BBPOS_CHIPPER2X,
    GET_TERMINAL_READERS_REQUEST_DEVICE_TYPE_VERIFONE_P400,
  ];

  static final $core.Map<$core.int, GetTerminalReadersRequest_GetTerminalReadersRequestDeviceType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetTerminalReadersRequest_GetTerminalReadersRequestDeviceType? valueOf($core.int value) => _byValue[value];

  const GetTerminalReadersRequest_GetTerminalReadersRequestDeviceType._($core.int v, $core.String n) : super(v, n);
}

class GetTerminalReadersRequest_GetTerminalReadersRequestStatus extends $pb.ProtobufEnum {
  static const GetTerminalReadersRequest_GetTerminalReadersRequestStatus GET_TERMINAL_READERS_REQUEST_STATUS_OFFLINE = GetTerminalReadersRequest_GetTerminalReadersRequestStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_TERMINAL_READERS_REQUEST_STATUS_OFFLINE');
  static const GetTerminalReadersRequest_GetTerminalReadersRequestStatus GET_TERMINAL_READERS_REQUEST_STATUS_ONLINE = GetTerminalReadersRequest_GetTerminalReadersRequestStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_TERMINAL_READERS_REQUEST_STATUS_ONLINE');

  static const $core.List<GetTerminalReadersRequest_GetTerminalReadersRequestStatus> values = <GetTerminalReadersRequest_GetTerminalReadersRequestStatus> [
    GET_TERMINAL_READERS_REQUEST_STATUS_OFFLINE,
    GET_TERMINAL_READERS_REQUEST_STATUS_ONLINE,
  ];

  static final $core.Map<$core.int, GetTerminalReadersRequest_GetTerminalReadersRequestStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetTerminalReadersRequest_GetTerminalReadersRequestStatus? valueOf($core.int value) => _byValue[value];

  const GetTerminalReadersRequest_GetTerminalReadersRequestStatus._($core.int v, $core.String n) : super(v, n);
}

class GetTopupsRequest_GetTopupsRequestStatus extends $pb.ProtobufEnum {
  static const GetTopupsRequest_GetTopupsRequestStatus GET_TOPUPS_REQUEST_STATUS_CANCELED = GetTopupsRequest_GetTopupsRequestStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_TOPUPS_REQUEST_STATUS_CANCELED');
  static const GetTopupsRequest_GetTopupsRequestStatus GET_TOPUPS_REQUEST_STATUS_FAILED = GetTopupsRequest_GetTopupsRequestStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_TOPUPS_REQUEST_STATUS_FAILED');
  static const GetTopupsRequest_GetTopupsRequestStatus GET_TOPUPS_REQUEST_STATUS_PENDING = GetTopupsRequest_GetTopupsRequestStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_TOPUPS_REQUEST_STATUS_PENDING');
  static const GetTopupsRequest_GetTopupsRequestStatus GET_TOPUPS_REQUEST_STATUS_SUCCEEDED = GetTopupsRequest_GetTopupsRequestStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GET_TOPUPS_REQUEST_STATUS_SUCCEEDED');

  static const $core.List<GetTopupsRequest_GetTopupsRequestStatus> values = <GetTopupsRequest_GetTopupsRequestStatus> [
    GET_TOPUPS_REQUEST_STATUS_CANCELED,
    GET_TOPUPS_REQUEST_STATUS_FAILED,
    GET_TOPUPS_REQUEST_STATUS_PENDING,
    GET_TOPUPS_REQUEST_STATUS_SUCCEEDED,
  ];

  static final $core.Map<$core.int, GetTopupsRequest_GetTopupsRequestStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GetTopupsRequest_GetTopupsRequestStatus? valueOf($core.int value) => _byValue[value];

  const GetTopupsRequest_GetTopupsRequestStatus._($core.int v, $core.String n) : super(v, n);
}

