// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: primitive.proto

#ifndef PROTOBUF_primitive_2eproto__INCLUDED
#define PROTOBUF_primitive_2eproto__INCLUDED

#include <string>

#include <google/protobuf/stubs/common.h>

#if GOOGLE_PROTOBUF_VERSION < 3005000
#error This file was generated by a newer version of protoc which is
#error incompatible with your Protocol Buffer headers.  Please update
#error your headers.
#endif
#if 3005001 < GOOGLE_PROTOBUF_MIN_PROTOC_VERSION
#error This file was generated by an older version of protoc which is
#error incompatible with your Protocol Buffer headers.  Please
#error regenerate this file with a newer version of protoc.
#endif

#include <google/protobuf/io/coded_stream.h>
#include <google/protobuf/arena.h>
#include <google/protobuf/arenastring.h>
#include <google/protobuf/generated_message_table_driven.h>
#include <google/protobuf/generated_message_util.h>
#include <google/protobuf/metadata.h>
#include <google/protobuf/message.h>
#include <google/protobuf/repeated_field.h>  // IWYU pragma: export
#include <google/protobuf/extension_set.h>  // IWYU pragma: export
#include <google/protobuf/generated_enum_reflection.h>
#include <google/protobuf/unknown_field_set.h>
// @@protoc_insertion_point(includes)

namespace protobuf_primitive_2eproto {
// Internal implementation detail -- do not use these members.
struct TableStruct {
  static const ::google::protobuf::internal::ParseTableField entries[];
  static const ::google::protobuf::internal::AuxillaryParseTableField aux[];
  static const ::google::protobuf::internal::ParseTable schema[4];
  static const ::google::protobuf::internal::FieldMetadata field_metadata[];
  static const ::google::protobuf::internal::SerializationTable serialization_table[];
  static const ::google::protobuf::uint32 offsets[];
};
void AddDescriptors();
void InitDefaultsSignatureImpl();
void InitDefaultsSignature();
void InitDefaultsuint256Impl();
void InitDefaultsuint256();
void InitDefaultsAmountImpl();
void InitDefaultsAmount();
void InitDefaultsPeerImpl();
void InitDefaultsPeer();
inline void InitDefaults() {
  InitDefaultsSignature();
  InitDefaultsuint256();
  InitDefaultsAmount();
  InitDefaultsPeer();
}
}  // namespace protobuf_primitive_2eproto
namespace iroha {
namespace protocol {
class Amount;
class AmountDefaultTypeInternal;
extern AmountDefaultTypeInternal _Amount_default_instance_;
class Peer;
class PeerDefaultTypeInternal;
extern PeerDefaultTypeInternal _Peer_default_instance_;
class Signature;
class SignatureDefaultTypeInternal;
extern SignatureDefaultTypeInternal _Signature_default_instance_;
class uint256;
class uint256DefaultTypeInternal;
extern uint256DefaultTypeInternal _uint256_default_instance_;
}  // namespace protocol
}  // namespace iroha
namespace iroha {
namespace protocol {

enum RolePermission {
  can_append_role = 0,
  can_create_role = 1,
  can_detach_role = 2,
  can_add_asset_qty = 3,
  can_subtract_asset_qty = 4,
  can_add_peer = 5,
  can_add_signatory = 6,
  can_remove_signatory = 7,
  can_set_quorum = 8,
  can_create_account = 9,
  can_set_detail = 10,
  can_create_asset = 11,
  can_transfer = 12,
  can_receive = 13,
  can_create_domain = 14,
  can_read_assets = 15,
  can_get_roles = 16,
  can_get_my_account = 17,
  can_get_all_accounts = 18,
  can_get_domain_accounts = 19,
  can_get_my_signatories = 20,
  can_get_all_signatories = 21,
  can_get_domain_signatories = 22,
  can_get_my_acc_ast = 23,
  can_get_all_acc_ast = 24,
  can_get_domain_acc_ast = 25,
  can_get_my_acc_detail = 26,
  can_get_all_acc_detail = 27,
  can_get_domain_acc_detail = 28,
  can_get_my_acc_txs = 29,
  can_get_all_acc_txs = 30,
  can_get_domain_acc_txs = 31,
  can_get_my_acc_ast_txs = 32,
  can_get_all_acc_ast_txs = 33,
  can_get_domain_acc_ast_txs = 34,
  can_get_my_txs = 35,
  can_get_all_txs = 36,
  can_get_blocks = 42,
  can_grant_can_set_my_quorum = 37,
  can_grant_can_add_my_signatory = 38,
  can_grant_can_remove_my_signatory = 39,
  can_grant_can_transfer_my_assets = 40,
  can_grant_can_set_my_account_detail = 41,
  RolePermission_INT_MIN_SENTINEL_DO_NOT_USE_ = ::google::protobuf::kint32min,
  RolePermission_INT_MAX_SENTINEL_DO_NOT_USE_ = ::google::protobuf::kint32max
};
bool RolePermission_IsValid(int value);
const RolePermission RolePermission_MIN = can_append_role;
const RolePermission RolePermission_MAX = can_get_blocks;
const int RolePermission_ARRAYSIZE = RolePermission_MAX + 1;

const ::google::protobuf::EnumDescriptor* RolePermission_descriptor();
inline const ::std::string& RolePermission_Name(RolePermission value) {
  return ::google::protobuf::internal::NameOfEnum(
    RolePermission_descriptor(), value);
}
inline bool RolePermission_Parse(
    const ::std::string& name, RolePermission* value) {
  return ::google::protobuf::internal::ParseNamedEnum<RolePermission>(
    RolePermission_descriptor(), name, value);
}
enum GrantablePermission {
  can_add_my_signatory = 0,
  can_remove_my_signatory = 1,
  can_set_my_quorum = 2,
  can_set_my_account_detail = 3,
  can_transfer_my_assets = 4,
  GrantablePermission_INT_MIN_SENTINEL_DO_NOT_USE_ = ::google::protobuf::kint32min,
  GrantablePermission_INT_MAX_SENTINEL_DO_NOT_USE_ = ::google::protobuf::kint32max
};
bool GrantablePermission_IsValid(int value);
const GrantablePermission GrantablePermission_MIN = can_add_my_signatory;
const GrantablePermission GrantablePermission_MAX = can_transfer_my_assets;
const int GrantablePermission_ARRAYSIZE = GrantablePermission_MAX + 1;

const ::google::protobuf::EnumDescriptor* GrantablePermission_descriptor();
inline const ::std::string& GrantablePermission_Name(GrantablePermission value) {
  return ::google::protobuf::internal::NameOfEnum(
    GrantablePermission_descriptor(), value);
}
inline bool GrantablePermission_Parse(
    const ::std::string& name, GrantablePermission* value) {
  return ::google::protobuf::internal::ParseNamedEnum<GrantablePermission>(
    GrantablePermission_descriptor(), name, value);
}
// ===================================================================

class Signature : public ::google::protobuf::Message /* @@protoc_insertion_point(class_definition:iroha.protocol.Signature) */ {
 public:
  Signature();
  virtual ~Signature();

  Signature(const Signature& from);

  inline Signature& operator=(const Signature& from) {
    CopyFrom(from);
    return *this;
  }
  #if LANG_CXX11
  Signature(Signature&& from) noexcept
    : Signature() {
    *this = ::std::move(from);
  }

  inline Signature& operator=(Signature&& from) noexcept {
    if (GetArenaNoVirtual() == from.GetArenaNoVirtual()) {
      if (this != &from) InternalSwap(&from);
    } else {
      CopyFrom(from);
    }
    return *this;
  }
  #endif
  static const ::google::protobuf::Descriptor* descriptor();
  static const Signature& default_instance();

  static void InitAsDefaultInstance();  // FOR INTERNAL USE ONLY
  static inline const Signature* internal_default_instance() {
    return reinterpret_cast<const Signature*>(
               &_Signature_default_instance_);
  }
  static PROTOBUF_CONSTEXPR int const kIndexInFileMessages =
    0;

  void Swap(Signature* other);
  friend void swap(Signature& a, Signature& b) {
    a.Swap(&b);
  }

  // implements Message ----------------------------------------------

  inline Signature* New() const PROTOBUF_FINAL { return New(NULL); }

  Signature* New(::google::protobuf::Arena* arena) const PROTOBUF_FINAL;
  void CopyFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void MergeFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void CopyFrom(const Signature& from);
  void MergeFrom(const Signature& from);
  void Clear() PROTOBUF_FINAL;
  bool IsInitialized() const PROTOBUF_FINAL;

  size_t ByteSizeLong() const PROTOBUF_FINAL;
  bool MergePartialFromCodedStream(
      ::google::protobuf::io::CodedInputStream* input) PROTOBUF_FINAL;
  void SerializeWithCachedSizes(
      ::google::protobuf::io::CodedOutputStream* output) const PROTOBUF_FINAL;
  ::google::protobuf::uint8* InternalSerializeWithCachedSizesToArray(
      bool deterministic, ::google::protobuf::uint8* target) const PROTOBUF_FINAL;
  int GetCachedSize() const PROTOBUF_FINAL { return _cached_size_; }
  private:
  void SharedCtor();
  void SharedDtor();
  void SetCachedSize(int size) const PROTOBUF_FINAL;
  void InternalSwap(Signature* other);
  private:
  inline ::google::protobuf::Arena* GetArenaNoVirtual() const {
    return NULL;
  }
  inline void* MaybeArenaPtr() const {
    return NULL;
  }
  public:

  ::google::protobuf::Metadata GetMetadata() const PROTOBUF_FINAL;

  // nested types ----------------------------------------------------

  // accessors -------------------------------------------------------

  // bytes pubkey = 1;
  void clear_pubkey();
  static const int kPubkeyFieldNumber = 1;
  const ::std::string& pubkey() const;
  void set_pubkey(const ::std::string& value);
  #if LANG_CXX11
  void set_pubkey(::std::string&& value);
  #endif
  void set_pubkey(const char* value);
  void set_pubkey(const void* value, size_t size);
  ::std::string* mutable_pubkey();
  ::std::string* release_pubkey();
  void set_allocated_pubkey(::std::string* pubkey);

  // bytes signature = 2;
  void clear_signature();
  static const int kSignatureFieldNumber = 2;
  const ::std::string& signature() const;
  void set_signature(const ::std::string& value);
  #if LANG_CXX11
  void set_signature(::std::string&& value);
  #endif
  void set_signature(const char* value);
  void set_signature(const void* value, size_t size);
  ::std::string* mutable_signature();
  ::std::string* release_signature();
  void set_allocated_signature(::std::string* signature);

  // @@protoc_insertion_point(class_scope:iroha.protocol.Signature)
 private:

  ::google::protobuf::internal::InternalMetadataWithArena _internal_metadata_;
  ::google::protobuf::internal::ArenaStringPtr pubkey_;
  ::google::protobuf::internal::ArenaStringPtr signature_;
  mutable int _cached_size_;
  friend struct ::protobuf_primitive_2eproto::TableStruct;
  friend void ::protobuf_primitive_2eproto::InitDefaultsSignatureImpl();
};
// -------------------------------------------------------------------

class uint256 : public ::google::protobuf::Message /* @@protoc_insertion_point(class_definition:iroha.protocol.uint256) */ {
 public:
  uint256();
  virtual ~uint256();

  uint256(const uint256& from);

  inline uint256& operator=(const uint256& from) {
    CopyFrom(from);
    return *this;
  }
  #if LANG_CXX11
  uint256(uint256&& from) noexcept
    : uint256() {
    *this = ::std::move(from);
  }

  inline uint256& operator=(uint256&& from) noexcept {
    if (GetArenaNoVirtual() == from.GetArenaNoVirtual()) {
      if (this != &from) InternalSwap(&from);
    } else {
      CopyFrom(from);
    }
    return *this;
  }
  #endif
  static const ::google::protobuf::Descriptor* descriptor();
  static const uint256& default_instance();

  static void InitAsDefaultInstance();  // FOR INTERNAL USE ONLY
  static inline const uint256* internal_default_instance() {
    return reinterpret_cast<const uint256*>(
               &_uint256_default_instance_);
  }
  static PROTOBUF_CONSTEXPR int const kIndexInFileMessages =
    1;

  void Swap(uint256* other);
  friend void swap(uint256& a, uint256& b) {
    a.Swap(&b);
  }

  // implements Message ----------------------------------------------

  inline uint256* New() const PROTOBUF_FINAL { return New(NULL); }

  uint256* New(::google::protobuf::Arena* arena) const PROTOBUF_FINAL;
  void CopyFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void MergeFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void CopyFrom(const uint256& from);
  void MergeFrom(const uint256& from);
  void Clear() PROTOBUF_FINAL;
  bool IsInitialized() const PROTOBUF_FINAL;

  size_t ByteSizeLong() const PROTOBUF_FINAL;
  bool MergePartialFromCodedStream(
      ::google::protobuf::io::CodedInputStream* input) PROTOBUF_FINAL;
  void SerializeWithCachedSizes(
      ::google::protobuf::io::CodedOutputStream* output) const PROTOBUF_FINAL;
  ::google::protobuf::uint8* InternalSerializeWithCachedSizesToArray(
      bool deterministic, ::google::protobuf::uint8* target) const PROTOBUF_FINAL;
  int GetCachedSize() const PROTOBUF_FINAL { return _cached_size_; }
  private:
  void SharedCtor();
  void SharedDtor();
  void SetCachedSize(int size) const PROTOBUF_FINAL;
  void InternalSwap(uint256* other);
  private:
  inline ::google::protobuf::Arena* GetArenaNoVirtual() const {
    return NULL;
  }
  inline void* MaybeArenaPtr() const {
    return NULL;
  }
  public:

  ::google::protobuf::Metadata GetMetadata() const PROTOBUF_FINAL;

  // nested types ----------------------------------------------------

  // accessors -------------------------------------------------------

  // uint64 first = 1;
  void clear_first();
  static const int kFirstFieldNumber = 1;
  ::google::protobuf::uint64 first() const;
  void set_first(::google::protobuf::uint64 value);

  // uint64 second = 2;
  void clear_second();
  static const int kSecondFieldNumber = 2;
  ::google::protobuf::uint64 second() const;
  void set_second(::google::protobuf::uint64 value);

  // uint64 third = 3;
  void clear_third();
  static const int kThirdFieldNumber = 3;
  ::google::protobuf::uint64 third() const;
  void set_third(::google::protobuf::uint64 value);

  // uint64 fourth = 4;
  void clear_fourth();
  static const int kFourthFieldNumber = 4;
  ::google::protobuf::uint64 fourth() const;
  void set_fourth(::google::protobuf::uint64 value);

  // @@protoc_insertion_point(class_scope:iroha.protocol.uint256)
 private:

  ::google::protobuf::internal::InternalMetadataWithArena _internal_metadata_;
  ::google::protobuf::uint64 first_;
  ::google::protobuf::uint64 second_;
  ::google::protobuf::uint64 third_;
  ::google::protobuf::uint64 fourth_;
  mutable int _cached_size_;
  friend struct ::protobuf_primitive_2eproto::TableStruct;
  friend void ::protobuf_primitive_2eproto::InitDefaultsuint256Impl();
};
// -------------------------------------------------------------------

class Amount : public ::google::protobuf::Message /* @@protoc_insertion_point(class_definition:iroha.protocol.Amount) */ {
 public:
  Amount();
  virtual ~Amount();

  Amount(const Amount& from);

  inline Amount& operator=(const Amount& from) {
    CopyFrom(from);
    return *this;
  }
  #if LANG_CXX11
  Amount(Amount&& from) noexcept
    : Amount() {
    *this = ::std::move(from);
  }

  inline Amount& operator=(Amount&& from) noexcept {
    if (GetArenaNoVirtual() == from.GetArenaNoVirtual()) {
      if (this != &from) InternalSwap(&from);
    } else {
      CopyFrom(from);
    }
    return *this;
  }
  #endif
  static const ::google::protobuf::Descriptor* descriptor();
  static const Amount& default_instance();

  static void InitAsDefaultInstance();  // FOR INTERNAL USE ONLY
  static inline const Amount* internal_default_instance() {
    return reinterpret_cast<const Amount*>(
               &_Amount_default_instance_);
  }
  static PROTOBUF_CONSTEXPR int const kIndexInFileMessages =
    2;

  void Swap(Amount* other);
  friend void swap(Amount& a, Amount& b) {
    a.Swap(&b);
  }

  // implements Message ----------------------------------------------

  inline Amount* New() const PROTOBUF_FINAL { return New(NULL); }

  Amount* New(::google::protobuf::Arena* arena) const PROTOBUF_FINAL;
  void CopyFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void MergeFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void CopyFrom(const Amount& from);
  void MergeFrom(const Amount& from);
  void Clear() PROTOBUF_FINAL;
  bool IsInitialized() const PROTOBUF_FINAL;

  size_t ByteSizeLong() const PROTOBUF_FINAL;
  bool MergePartialFromCodedStream(
      ::google::protobuf::io::CodedInputStream* input) PROTOBUF_FINAL;
  void SerializeWithCachedSizes(
      ::google::protobuf::io::CodedOutputStream* output) const PROTOBUF_FINAL;
  ::google::protobuf::uint8* InternalSerializeWithCachedSizesToArray(
      bool deterministic, ::google::protobuf::uint8* target) const PROTOBUF_FINAL;
  int GetCachedSize() const PROTOBUF_FINAL { return _cached_size_; }
  private:
  void SharedCtor();
  void SharedDtor();
  void SetCachedSize(int size) const PROTOBUF_FINAL;
  void InternalSwap(Amount* other);
  private:
  inline ::google::protobuf::Arena* GetArenaNoVirtual() const {
    return NULL;
  }
  inline void* MaybeArenaPtr() const {
    return NULL;
  }
  public:

  ::google::protobuf::Metadata GetMetadata() const PROTOBUF_FINAL;

  // nested types ----------------------------------------------------

  // accessors -------------------------------------------------------

  // .iroha.protocol.uint256 value = 1;
  bool has_value() const;
  void clear_value();
  static const int kValueFieldNumber = 1;
  const ::iroha::protocol::uint256& value() const;
  ::iroha::protocol::uint256* release_value();
  ::iroha::protocol::uint256* mutable_value();
  void set_allocated_value(::iroha::protocol::uint256* value);

  // uint32 precision = 2;
  void clear_precision();
  static const int kPrecisionFieldNumber = 2;
  ::google::protobuf::uint32 precision() const;
  void set_precision(::google::protobuf::uint32 value);

  // @@protoc_insertion_point(class_scope:iroha.protocol.Amount)
 private:

  ::google::protobuf::internal::InternalMetadataWithArena _internal_metadata_;
  ::iroha::protocol::uint256* value_;
  ::google::protobuf::uint32 precision_;
  mutable int _cached_size_;
  friend struct ::protobuf_primitive_2eproto::TableStruct;
  friend void ::protobuf_primitive_2eproto::InitDefaultsAmountImpl();
};
// -------------------------------------------------------------------

class Peer : public ::google::protobuf::Message /* @@protoc_insertion_point(class_definition:iroha.protocol.Peer) */ {
 public:
  Peer();
  virtual ~Peer();

  Peer(const Peer& from);

  inline Peer& operator=(const Peer& from) {
    CopyFrom(from);
    return *this;
  }
  #if LANG_CXX11
  Peer(Peer&& from) noexcept
    : Peer() {
    *this = ::std::move(from);
  }

  inline Peer& operator=(Peer&& from) noexcept {
    if (GetArenaNoVirtual() == from.GetArenaNoVirtual()) {
      if (this != &from) InternalSwap(&from);
    } else {
      CopyFrom(from);
    }
    return *this;
  }
  #endif
  static const ::google::protobuf::Descriptor* descriptor();
  static const Peer& default_instance();

  static void InitAsDefaultInstance();  // FOR INTERNAL USE ONLY
  static inline const Peer* internal_default_instance() {
    return reinterpret_cast<const Peer*>(
               &_Peer_default_instance_);
  }
  static PROTOBUF_CONSTEXPR int const kIndexInFileMessages =
    3;

  void Swap(Peer* other);
  friend void swap(Peer& a, Peer& b) {
    a.Swap(&b);
  }

  // implements Message ----------------------------------------------

  inline Peer* New() const PROTOBUF_FINAL { return New(NULL); }

  Peer* New(::google::protobuf::Arena* arena) const PROTOBUF_FINAL;
  void CopyFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void MergeFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void CopyFrom(const Peer& from);
  void MergeFrom(const Peer& from);
  void Clear() PROTOBUF_FINAL;
  bool IsInitialized() const PROTOBUF_FINAL;

  size_t ByteSizeLong() const PROTOBUF_FINAL;
  bool MergePartialFromCodedStream(
      ::google::protobuf::io::CodedInputStream* input) PROTOBUF_FINAL;
  void SerializeWithCachedSizes(
      ::google::protobuf::io::CodedOutputStream* output) const PROTOBUF_FINAL;
  ::google::protobuf::uint8* InternalSerializeWithCachedSizesToArray(
      bool deterministic, ::google::protobuf::uint8* target) const PROTOBUF_FINAL;
  int GetCachedSize() const PROTOBUF_FINAL { return _cached_size_; }
  private:
  void SharedCtor();
  void SharedDtor();
  void SetCachedSize(int size) const PROTOBUF_FINAL;
  void InternalSwap(Peer* other);
  private:
  inline ::google::protobuf::Arena* GetArenaNoVirtual() const {
    return NULL;
  }
  inline void* MaybeArenaPtr() const {
    return NULL;
  }
  public:

  ::google::protobuf::Metadata GetMetadata() const PROTOBUF_FINAL;

  // nested types ----------------------------------------------------

  // accessors -------------------------------------------------------

  // string address = 1;
  void clear_address();
  static const int kAddressFieldNumber = 1;
  const ::std::string& address() const;
  void set_address(const ::std::string& value);
  #if LANG_CXX11
  void set_address(::std::string&& value);
  #endif
  void set_address(const char* value);
  void set_address(const char* value, size_t size);
  ::std::string* mutable_address();
  ::std::string* release_address();
  void set_allocated_address(::std::string* address);

  // bytes peer_key = 2;
  void clear_peer_key();
  static const int kPeerKeyFieldNumber = 2;
  const ::std::string& peer_key() const;
  void set_peer_key(const ::std::string& value);
  #if LANG_CXX11
  void set_peer_key(::std::string&& value);
  #endif
  void set_peer_key(const char* value);
  void set_peer_key(const void* value, size_t size);
  ::std::string* mutable_peer_key();
  ::std::string* release_peer_key();
  void set_allocated_peer_key(::std::string* peer_key);

  // @@protoc_insertion_point(class_scope:iroha.protocol.Peer)
 private:

  ::google::protobuf::internal::InternalMetadataWithArena _internal_metadata_;
  ::google::protobuf::internal::ArenaStringPtr address_;
  ::google::protobuf::internal::ArenaStringPtr peer_key_;
  mutable int _cached_size_;
  friend struct ::protobuf_primitive_2eproto::TableStruct;
  friend void ::protobuf_primitive_2eproto::InitDefaultsPeerImpl();
};
// ===================================================================


// ===================================================================

#ifdef __GNUC__
  #pragma GCC diagnostic push
  #pragma GCC diagnostic ignored "-Wstrict-aliasing"
#endif  // __GNUC__
// Signature

// bytes pubkey = 1;
inline void Signature::clear_pubkey() {
  pubkey_.ClearToEmptyNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline const ::std::string& Signature::pubkey() const {
  // @@protoc_insertion_point(field_get:iroha.protocol.Signature.pubkey)
  return pubkey_.GetNoArena();
}
inline void Signature::set_pubkey(const ::std::string& value) {
  
  pubkey_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), value);
  // @@protoc_insertion_point(field_set:iroha.protocol.Signature.pubkey)
}
#if LANG_CXX11
inline void Signature::set_pubkey(::std::string&& value) {
  
  pubkey_.SetNoArena(
    &::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::move(value));
  // @@protoc_insertion_point(field_set_rvalue:iroha.protocol.Signature.pubkey)
}
#endif
inline void Signature::set_pubkey(const char* value) {
  GOOGLE_DCHECK(value != NULL);
  
  pubkey_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::string(value));
  // @@protoc_insertion_point(field_set_char:iroha.protocol.Signature.pubkey)
}
inline void Signature::set_pubkey(const void* value, size_t size) {
  
  pubkey_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(),
      ::std::string(reinterpret_cast<const char*>(value), size));
  // @@protoc_insertion_point(field_set_pointer:iroha.protocol.Signature.pubkey)
}
inline ::std::string* Signature::mutable_pubkey() {
  
  // @@protoc_insertion_point(field_mutable:iroha.protocol.Signature.pubkey)
  return pubkey_.MutableNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline ::std::string* Signature::release_pubkey() {
  // @@protoc_insertion_point(field_release:iroha.protocol.Signature.pubkey)
  
  return pubkey_.ReleaseNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline void Signature::set_allocated_pubkey(::std::string* pubkey) {
  if (pubkey != NULL) {
    
  } else {
    
  }
  pubkey_.SetAllocatedNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), pubkey);
  // @@protoc_insertion_point(field_set_allocated:iroha.protocol.Signature.pubkey)
}

// bytes signature = 2;
inline void Signature::clear_signature() {
  signature_.ClearToEmptyNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline const ::std::string& Signature::signature() const {
  // @@protoc_insertion_point(field_get:iroha.protocol.Signature.signature)
  return signature_.GetNoArena();
}
inline void Signature::set_signature(const ::std::string& value) {
  
  signature_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), value);
  // @@protoc_insertion_point(field_set:iroha.protocol.Signature.signature)
}
#if LANG_CXX11
inline void Signature::set_signature(::std::string&& value) {
  
  signature_.SetNoArena(
    &::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::move(value));
  // @@protoc_insertion_point(field_set_rvalue:iroha.protocol.Signature.signature)
}
#endif
inline void Signature::set_signature(const char* value) {
  GOOGLE_DCHECK(value != NULL);
  
  signature_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::string(value));
  // @@protoc_insertion_point(field_set_char:iroha.protocol.Signature.signature)
}
inline void Signature::set_signature(const void* value, size_t size) {
  
  signature_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(),
      ::std::string(reinterpret_cast<const char*>(value), size));
  // @@protoc_insertion_point(field_set_pointer:iroha.protocol.Signature.signature)
}
inline ::std::string* Signature::mutable_signature() {
  
  // @@protoc_insertion_point(field_mutable:iroha.protocol.Signature.signature)
  return signature_.MutableNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline ::std::string* Signature::release_signature() {
  // @@protoc_insertion_point(field_release:iroha.protocol.Signature.signature)
  
  return signature_.ReleaseNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline void Signature::set_allocated_signature(::std::string* signature) {
  if (signature != NULL) {
    
  } else {
    
  }
  signature_.SetAllocatedNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), signature);
  // @@protoc_insertion_point(field_set_allocated:iroha.protocol.Signature.signature)
}

// -------------------------------------------------------------------

// uint256

// uint64 first = 1;
inline void uint256::clear_first() {
  first_ = GOOGLE_ULONGLONG(0);
}
inline ::google::protobuf::uint64 uint256::first() const {
  // @@protoc_insertion_point(field_get:iroha.protocol.uint256.first)
  return first_;
}
inline void uint256::set_first(::google::protobuf::uint64 value) {
  
  first_ = value;
  // @@protoc_insertion_point(field_set:iroha.protocol.uint256.first)
}

// uint64 second = 2;
inline void uint256::clear_second() {
  second_ = GOOGLE_ULONGLONG(0);
}
inline ::google::protobuf::uint64 uint256::second() const {
  // @@protoc_insertion_point(field_get:iroha.protocol.uint256.second)
  return second_;
}
inline void uint256::set_second(::google::protobuf::uint64 value) {
  
  second_ = value;
  // @@protoc_insertion_point(field_set:iroha.protocol.uint256.second)
}

// uint64 third = 3;
inline void uint256::clear_third() {
  third_ = GOOGLE_ULONGLONG(0);
}
inline ::google::protobuf::uint64 uint256::third() const {
  // @@protoc_insertion_point(field_get:iroha.protocol.uint256.third)
  return third_;
}
inline void uint256::set_third(::google::protobuf::uint64 value) {
  
  third_ = value;
  // @@protoc_insertion_point(field_set:iroha.protocol.uint256.third)
}

// uint64 fourth = 4;
inline void uint256::clear_fourth() {
  fourth_ = GOOGLE_ULONGLONG(0);
}
inline ::google::protobuf::uint64 uint256::fourth() const {
  // @@protoc_insertion_point(field_get:iroha.protocol.uint256.fourth)
  return fourth_;
}
inline void uint256::set_fourth(::google::protobuf::uint64 value) {
  
  fourth_ = value;
  // @@protoc_insertion_point(field_set:iroha.protocol.uint256.fourth)
}

// -------------------------------------------------------------------

// Amount

// .iroha.protocol.uint256 value = 1;
inline bool Amount::has_value() const {
  return this != internal_default_instance() && value_ != NULL;
}
inline void Amount::clear_value() {
  if (GetArenaNoVirtual() == NULL && value_ != NULL) {
    delete value_;
  }
  value_ = NULL;
}
inline const ::iroha::protocol::uint256& Amount::value() const {
  const ::iroha::protocol::uint256* p = value_;
  // @@protoc_insertion_point(field_get:iroha.protocol.Amount.value)
  return p != NULL ? *p : *reinterpret_cast<const ::iroha::protocol::uint256*>(
      &::iroha::protocol::_uint256_default_instance_);
}
inline ::iroha::protocol::uint256* Amount::release_value() {
  // @@protoc_insertion_point(field_release:iroha.protocol.Amount.value)
  
  ::iroha::protocol::uint256* temp = value_;
  value_ = NULL;
  return temp;
}
inline ::iroha::protocol::uint256* Amount::mutable_value() {
  
  if (value_ == NULL) {
    value_ = new ::iroha::protocol::uint256;
  }
  // @@protoc_insertion_point(field_mutable:iroha.protocol.Amount.value)
  return value_;
}
inline void Amount::set_allocated_value(::iroha::protocol::uint256* value) {
  ::google::protobuf::Arena* message_arena = GetArenaNoVirtual();
  if (message_arena == NULL) {
    delete value_;
  }
  if (value) {
    ::google::protobuf::Arena* submessage_arena = NULL;
    if (message_arena != submessage_arena) {
      value = ::google::protobuf::internal::GetOwnedMessage(
          message_arena, value, submessage_arena);
    }
    
  } else {
    
  }
  value_ = value;
  // @@protoc_insertion_point(field_set_allocated:iroha.protocol.Amount.value)
}

// uint32 precision = 2;
inline void Amount::clear_precision() {
  precision_ = 0u;
}
inline ::google::protobuf::uint32 Amount::precision() const {
  // @@protoc_insertion_point(field_get:iroha.protocol.Amount.precision)
  return precision_;
}
inline void Amount::set_precision(::google::protobuf::uint32 value) {
  
  precision_ = value;
  // @@protoc_insertion_point(field_set:iroha.protocol.Amount.precision)
}

// -------------------------------------------------------------------

// Peer

// string address = 1;
inline void Peer::clear_address() {
  address_.ClearToEmptyNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline const ::std::string& Peer::address() const {
  // @@protoc_insertion_point(field_get:iroha.protocol.Peer.address)
  return address_.GetNoArena();
}
inline void Peer::set_address(const ::std::string& value) {
  
  address_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), value);
  // @@protoc_insertion_point(field_set:iroha.protocol.Peer.address)
}
#if LANG_CXX11
inline void Peer::set_address(::std::string&& value) {
  
  address_.SetNoArena(
    &::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::move(value));
  // @@protoc_insertion_point(field_set_rvalue:iroha.protocol.Peer.address)
}
#endif
inline void Peer::set_address(const char* value) {
  GOOGLE_DCHECK(value != NULL);
  
  address_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::string(value));
  // @@protoc_insertion_point(field_set_char:iroha.protocol.Peer.address)
}
inline void Peer::set_address(const char* value, size_t size) {
  
  address_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(),
      ::std::string(reinterpret_cast<const char*>(value), size));
  // @@protoc_insertion_point(field_set_pointer:iroha.protocol.Peer.address)
}
inline ::std::string* Peer::mutable_address() {
  
  // @@protoc_insertion_point(field_mutable:iroha.protocol.Peer.address)
  return address_.MutableNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline ::std::string* Peer::release_address() {
  // @@protoc_insertion_point(field_release:iroha.protocol.Peer.address)
  
  return address_.ReleaseNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline void Peer::set_allocated_address(::std::string* address) {
  if (address != NULL) {
    
  } else {
    
  }
  address_.SetAllocatedNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), address);
  // @@protoc_insertion_point(field_set_allocated:iroha.protocol.Peer.address)
}

// bytes peer_key = 2;
inline void Peer::clear_peer_key() {
  peer_key_.ClearToEmptyNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline const ::std::string& Peer::peer_key() const {
  // @@protoc_insertion_point(field_get:iroha.protocol.Peer.peer_key)
  return peer_key_.GetNoArena();
}
inline void Peer::set_peer_key(const ::std::string& value) {
  
  peer_key_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), value);
  // @@protoc_insertion_point(field_set:iroha.protocol.Peer.peer_key)
}
#if LANG_CXX11
inline void Peer::set_peer_key(::std::string&& value) {
  
  peer_key_.SetNoArena(
    &::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::move(value));
  // @@protoc_insertion_point(field_set_rvalue:iroha.protocol.Peer.peer_key)
}
#endif
inline void Peer::set_peer_key(const char* value) {
  GOOGLE_DCHECK(value != NULL);
  
  peer_key_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::string(value));
  // @@protoc_insertion_point(field_set_char:iroha.protocol.Peer.peer_key)
}
inline void Peer::set_peer_key(const void* value, size_t size) {
  
  peer_key_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(),
      ::std::string(reinterpret_cast<const char*>(value), size));
  // @@protoc_insertion_point(field_set_pointer:iroha.protocol.Peer.peer_key)
}
inline ::std::string* Peer::mutable_peer_key() {
  
  // @@protoc_insertion_point(field_mutable:iroha.protocol.Peer.peer_key)
  return peer_key_.MutableNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline ::std::string* Peer::release_peer_key() {
  // @@protoc_insertion_point(field_release:iroha.protocol.Peer.peer_key)
  
  return peer_key_.ReleaseNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline void Peer::set_allocated_peer_key(::std::string* peer_key) {
  if (peer_key != NULL) {
    
  } else {
    
  }
  peer_key_.SetAllocatedNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), peer_key);
  // @@protoc_insertion_point(field_set_allocated:iroha.protocol.Peer.peer_key)
}

#ifdef __GNUC__
  #pragma GCC diagnostic pop
#endif  // __GNUC__
// -------------------------------------------------------------------

// -------------------------------------------------------------------

// -------------------------------------------------------------------


// @@protoc_insertion_point(namespace_scope)

}  // namespace protocol
}  // namespace iroha

namespace google {
namespace protobuf {

template <> struct is_proto_enum< ::iroha::protocol::RolePermission> : ::google::protobuf::internal::true_type {};
template <>
inline const EnumDescriptor* GetEnumDescriptor< ::iroha::protocol::RolePermission>() {
  return ::iroha::protocol::RolePermission_descriptor();
}
template <> struct is_proto_enum< ::iroha::protocol::GrantablePermission> : ::google::protobuf::internal::true_type {};
template <>
inline const EnumDescriptor* GetEnumDescriptor< ::iroha::protocol::GrantablePermission>() {
  return ::iroha::protocol::GrantablePermission_descriptor();
}

}  // namespace protobuf
}  // namespace google

// @@protoc_insertion_point(global_scope)

#endif  // PROTOBUF_primitive_2eproto__INCLUDED
