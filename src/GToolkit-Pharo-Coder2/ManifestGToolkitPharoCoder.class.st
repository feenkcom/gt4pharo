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
	@derive remove(primitive: true)
}.

package {
	tags(s): #tags,
	@derive model(name: package)
}.

tag(s) {
	@derive add(primitive: true),
	@derive remove(primitive: true)
}.

tag {
	behavior(s): #behaviors,
	@derive model(name: tag)
}.

behavior(s) {
	@derive add(primitive: true),
	@derive remove(primitive: true)
}.

behavior {
	protocol(s): #protocols,
	@derive model(name: behavior)
}.

protocol(s) {
	@derive add(primitive: true),
	@derive remove(primitive: true)
}.

protocol {
	method(s): #methods,
	@derive model(name: protocol)
}.

method(s) {
	@derive add(primitive: true),
	@derive remove(primitive: true)
}.

method {
	@derive model(name: method)
}."
]

{ #category : #'api - coder model' }
ManifestGToolkitPharoCoder class >> packageCoderViewModel [
"@prefix Gt2
@package 'GToolkit-Pharo-Coder2'
@tag 'Browser'
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
	tag(s): #pharoTagsCoder,
}.

packageView(s) {
	@derive add(primitive: true),
	@derive remove(primitive: true),
	@derive selection
}.

packageView {
	@derive selection
}.

packageAction(s) {
	@derive add(primitive: true),
	@derive remove(primitive: true),
}.

packageAction {
	@derive property(name: expanded)
}"
]
