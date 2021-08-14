import 'package:flutter/cupertino.dart';

class Const {
  /// OAuth 应用程序的作用域
  /// https://docs.github.com/cn/developers/apps/building-oauth-apps/scopes-for-oauth-apps
  /// 空：授予对公共信息的只读访问权限（包括用户个人资料信息、公共仓库信息和 gist）
  /// repo：授予对仓库（包括私有仓库）的完全访问权限。 这包括对仓库和组织的代码、提交状态、仓库和组织项目、邀请、协作者、添加团队成员身份、部署状态以及仓库 web 挂钩的读取/写入权限。 还授予管理用户项目的权限。
  /// repo:status：授予对公共和私有仓库提交状态的读/写权限。 仅在授予其他用户或服务对私有仓库提交状态的访问权限而不授予对代码的访问权限时，才需要此作用域。
  /// repo_deployment：授予对公共和私有仓库的部署状态的访问权限。 仅在授予其他用户或服务对部署状态的访问权限而不授予对代码的访问权限时，才需要此作用域。
  /// public_repo：将访问权限限制为公共仓库。 这包括对公共仓库和组织的代码、提交状态、仓库项目、协作者以及部署状态的读取/写入权限。 标星公共仓库也需要此权限。
  /// repo:invite：授予接受/拒绝仓库协作邀请的权限。 仅在授予其他用户或服务对邀请的访问权限而不授予对代码的访问权限时，才需要此作用域。
  /// security_events：授予：
  ///   对 代码扫描 API 中安全事件的读取和写入权限
  ///   对 秘密扫描 API 中安全事件的读取和写入权限
  ///   仅在授予其他用户或服务对安全事件的访问权限而不授予对代码的访问权限时，才需要此作用域。
  /// admin:repo_hook：授予对公共和私人仓库中仓库挂钩的读取、写入、ping 和删除权限。 repo 和 public_repo 范围授予对仓库（包括仓库挂钩）的完全访问权限。 使用 admin:repo_hook 作用域将访问权限限制为仅仓库挂钩。
  /// write:repo_hook：授予对公共或私人仓库中仓库挂钩的读取、写入和 ping 权限。
  /// read:repo_hook：授予对公共或私人仓库中仓库挂钩的读取和 ping 权限。
  /// admin:org：全面管理组织及其团队、项目和成员。
  /// write:org：对组织成员身份、组织项目和团队成员身份的读取和写入权限。
  /// read:org：对组织成员身份、组织项目和团队成员身份的只读权限。
  /// admin:public_key：全面管理公钥。
  /// write:public_key：创建、列出和查看公钥的详细信息。
  /// read:public_key：列出和查看公钥的详细信息。
  /// admin:org_hook：授予对组织挂钩的读取、写入、ping 和删除权限。 注：OAuth 令牌只能对由 OAuth 应用程序创建的组织挂钩执行这些操作。 个人访问令牌只能对用户创建的组织挂钩执行这些操作。
  /// gist：授予对 gist 的写入权限。
  /// notifications：授予：
  ///   对用户通知的读取权限
  ///   对线程的标记读取权限
  ///   对仓库的关注和取消关注权限，以及
  ///   对线程订阅的读取、写入和删除权限。
  /// user：仅授予对个人资料的读取/写入权限。 请注意，此作用域包括 user:email 和 user:follow。
  /// read:user：授予读取用户个人资料数据的权限。
  /// user:email：授予对用户电子邮件地址的读取权限。
  /// user:follow：授予关注或取消关注其他用户的权限。
  /// delete_repo：授予删除可管理仓库的权限。
  /// write:discussion：授予对团队讨论的读取和写入权限。
  /// read:discussion：允许读取团队讨论。
  /// write:packages：授予在 GitHub Packages 中上传或发布包的权限。 更多信息请参阅“发布包”。
  /// read:packages：授予从 GitHub Packages 下载或安装包的权限。 更多信息请参阅“安装包”。
  /// delete:packages：授予从 GitHub Packages 删除包的权限。 更多信息请参阅“删除和恢复包”。
  /// admin:gpg_key：全面管理 GPG 密钥。
  /// write:gpg_key：创建、列出和查看 GPG 密钥的详细信息。
  /// read:gpg_key：列出和查看 GPG 密钥的详细信息。
  /// workflow：授予添加和更新 GitHub Actions 工作流程文件的权限。 如果在同一仓库中的另一个分支上存在相同的文件(具有相同的路径和内容)，则工作流程文件可以在没有此作用域的情况下提交。 工作流程文件可以暴露可能有不同范围集的 GITHUB_TOKEN。 更多信息请参阅“工作流程中的身份验证。
  static const allScope = 'repo repo:status repo_deployment public_repo repo:invite security_events admin:repo_hook write:repo_hook read:repo_hook admin:org write:org read:org admin:public_key	write:public_key read:public_key admin:org_hook gist notifications user read:user user:email user:follow delete_repo write:discussion read:discussion write:packages read:packages delete:packages admin:gpg_key write:gpg_key read:gpg_key workflow';
  static const scope = 'repo user admin:org notifications read:discussion';

  /// Github api 支持的每页最大行数
  static const perPageMax = 100;
  /// Github api 推荐的每页最行数
  static const perPageNormal = 30;
  /// github app client id
  static const clientId = 'c868cf1dc9c48103bb55';
  /// github app callback url
  static const redirectUri = 'http://localhost/oauth/redirect';
  static final clientSecret = '20bf38742868ad776331c718d98b4670c0eddb8b';

  static const font1 = 'NotoSerifSC';

  static const zhLocale = const Locale('zh');
  static const enLocale = const Locale('en');



}