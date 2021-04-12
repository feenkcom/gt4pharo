"
Navigation is generated from:

@project Gt
@prefix Pharo
@suffix Navigation
@package ''GToolkit-Pharo-Coder-UI''
@tag ''Navigation''

@derive notify
@derive selection
@derive api
@derive name
@derive typeTest
@derive print
@derive phlowList

package(s) => tag(s) => class(es).

package(s) <GtPharoPackagesCoder::TGtWithPharoPackagesCoderModel> {
	items: #coders
}.
package <GtPharoPackageCoder::TGtWithPharoPackageCoderModel> { 
	tag(s): #packageTagsCoder
}.
tag(s) <GtPharoPackageTagCoders::TGtWithPharoPackageTagsCoderModel> {
	items: #coders
}.
tag <GtPharoPackageTagCoder::TGtWithPharoPackageTagCoderModel> {
	class(es): #classesCoder
}.
class(es) <GtPharoClassesCoder::TGtWithPharoClassesCoderModel> {
	items: #coders
}.
class <GtPharoBehaviorCoder::TGtWithPharoBehaviorCoderModel>
"
Class {
	#name : #ManifestGToolkitPharoCoderUI,
	#superclass : #PackageManifest,
	#category : #'GToolkit-Pharo-Coder-UI-Manifest'
}
