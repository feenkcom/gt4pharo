"
Navigation is generated from:

@project Gt
@prefix Pharo
@suffix Navigation
@package 'GToolkit-Pharo-Coder-UI'
@tag Navigation

@derive notify
@derive selection
@derive api
@derive name
@derive typeTest
@derive print
@derive phlowList

package(s) => behavior(s) and tag(s).
tag => behavior(s).

package(s) <GtPharoPackagesCoder::TGtWithPharoPackagesCoderModel> {
	items: #coders
}.
package <GtPharoPackageCoder::TGtWithPharoPackageCoderModel> { 
	tag(s): #packageTagsCoder,
	behavior(s): #classesCoder
}.
tag(s) <GtPharoPackageTagCoders::TGtWithPharoPackageTagsCoderModel> {
	items: #coders
}.
tag <GtPharoPackageTagCoder::TGtWithPharoPackageTagCoderModel> {
	behavior(s): #classesCoder
}.
behavior(s) <GtPharoClassesCoder::TGtWithPharoClassesCoderModel> {
	items: #coders
}.
behavior <GtPharoBehaviorCoder::TGtWithPharoBehaviorCoderModel>
"
Class {
	#name : #ManifestGToolkitPharoCoderUI,
	#superclass : #PackageManifest,
	#category : #'GToolkit-Pharo-Coder-UI-Manifest'
}
