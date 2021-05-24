"
Some of the code was auto-generated
"
Class {
	#name : #ManifestGToolkitPharoCoder,
	#superclass : #PackageManifest,
	#category : #'GToolkit-Pharo-Coder2-Manifest'
}

{ #category : #'api - coder model' }
ManifestGToolkitPharoCoder class >> coderModel [
"@prefix Gt2
@package 'GToolkit-Pharo-Coder2'
@objectTag 'Models'
@project Pharo
@suffix Coder

@derive children
@derive parent
@derive phlowList
@derive announcer
@derive notifier
@derive api
@derive print
@derive typeTest

package(s) => tag(s) => behavior(s) => protocol(s) => method(s).

package(s) {
	@derive add(primitive: true),
	@derive remove(primitive: true),
	@derive model(name: pharoPackages)
}.

package {
	tag(s): #tags,
	@derive model(name: pharoPackage)
}.

tag(s) {
	@derive add(primitive: true),
	@derive remove(primitive: true),
	@derive model(name: pharoTags)
}.

tag {
	behavior(s): #behaviors,
	@derive model(name: pharoTag)
}.

behavior(s) {
	@derive add(primitive: true),
	@derive remove(primitive: true)
}.

behavior {
	protocol(s): #protocols,
	@derive model(name: pharoBehavior)
}.

protocol(s) {
	@derive add(primitive: true),
	@derive remove(primitive: true)
}.

protocol {
	method(s): #meth,
	@derive model(name: pharoProtocol)
}.

method(s) {
	@derive add(primitive: true),
	@derive remove(primitive: true)
}.

method {
	@derive model(name: pharoMethod)
}."
]

{ #category : #'api - coder model' }
ManifestGToolkitPharoCoder class >> coderViewModel [
"@prefix Gt2
@package 'GToolkit-Pharo-Coder2'
@tag 'Navigation'
@objectTag 'View Models'
@project Pharo
@suffix CoderNavigationViewModel

@derive children
@derive parent
@derive name
@derive print
@derive announcer
@derive notifier
@derive typeTest
@derive phlowList
@derive api
@derive selection

package(s) => tag(s) => behavior(s).

package(s) {
	@derive model(api: TGt2WithPharoPackagesCoder),
	@derive add(
		delegate: #addPharoPackageCoder:,
		subscribe: Gt2PharoPackageCoderAddedAnnouncement),
	@derive remove(
		delegate: #removePharoPackageCoder:,
		subscribe: Gt2PharoPackageCoderRemovedAnnouncement),
	items: #pharoPackageCoders
}.

package {
	tag(s): #pharoTagsCoder,
	@derive model(api: TGt2WithPharoPackageCoder)
}.

tag(s) {
	@derive model(api: TGt2WithPharoTagsCoder),
	@derive add(
		delegate: #addPharoTagCoder:,
		subscribe: Gt2PharoTagCoderAddedAnnouncement),
	@derive remove(
		delegate: #removePharoTagCoder:,
		subscribe: Gt2PharoTagCoderRemovedAnnouncement),
	items: #pharoTagCoders
}.

tag {
	behavior(s): #pharoBehaviorsCoder,
	@derive model(api: TGt2WithPharoTagCoder)
}.

behavior(s) {
	@derive model(api: TGt2WithPharoBehaviorsCoder),
	@derive add(
		delegate: #addPharoBehaviorCoder:,
		subscribe: Gt2PharoBehaviorCoderAddedAnnouncement),
	@derive remove(
		delegate: #removePharoBehaviorCoder:,
		subscribe: Gt2PharoBehaviorCoderRemovedAnnouncement),
	items: #pharoBehaviorCoders
}.

behavior {
	@derive model(api: TGt2WithPharoBehaviorCoder)
}"
]

{ #category : #'api - coder model' }
ManifestGToolkitPharoCoder class >> packageCoderViewModel [
"@prefix Gt2
@package 'GToolkit-Pharo-Coder2'
@tag 'Package Coder'
@objectTag 'View Models'
@project Pharo
@suffix CoderViewModel

@derive children
@derive parent
@derive name
@derive print
@derive announcer
@derive notifier
@derive phlowList
@derive api

package(s) => packageView(s) and packageAction(s).

package(s) {
	@derive model(api: TGt2WithPharoPackagesCoder),
	@derive add(
		delegate: #addPharoPackageCoder:,
		subscribe: Gt2PharoPackageCoderAddedAnnouncement),
	@derive remove(
		delegate: #removePharoPackageCoder:,
		subscribe: Gt2PharoPackageCoderRemovedAnnouncement),
	items: #pharoPackageCoders
}.

package {
	@derive model(api: TGt2WithPharoPackageCoder),
	packageView(s): #gtPackageViews
}.

packageView(s) {
	@derive add(primitive: true),
	@derive remove(primitive: true),
	@derive selection,
	@derive model(name: phlowViews)
}.

packageView {
	@derive selection,
	@derive model(name: phlowView)
}.

packageAction(s) {
	@derive add(primitive: true),
	@derive remove(primitive: true),
}.

packageAction {
	@derive property(name: expanded)
}"
]
