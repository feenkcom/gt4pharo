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
