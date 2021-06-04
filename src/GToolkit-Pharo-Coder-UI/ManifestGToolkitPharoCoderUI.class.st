"
Main view models are generated from {{gtMethod:ManifestGToolkitPharoCoderUI class>>#mainViewModels}}.
Navigation is generated from {{gtMethod:ManifestGToolkitPharoCoderUI class>>#navigationViewModels}}.

"
Class {
	#name : #ManifestGToolkitPharoCoderUI,
	#superclass : #PackageManifest,
	#category : #'GToolkit-Pharo-Coder-UI-Manifest'
}

{ #category : #'code generation' }
ManifestGToolkitPharoCoderUI class >> mainViewModels [
"
@project Gt
@prefix Pharo
@package 'GToolkit-Pharo-Coder-UI'

@derive notify
@derive api
@derive name
@derive typeTest
@derive print

package(s) => packageTag(s).

package(s) <GtPharoPackagesCoder::TGtWithPharoPackagesCoderModel> {
	items: #coders
}.

package <GtPharoPackageCoder::TGtWithPharoPackageTagCoderModel> {
	packageTag(s): #packageTagsCoder
}.

packageTag(s) <GtPharoPackageTagCoders::TGtWithPharoPackageTagsCoderModel> {
	items: #coders
}.

packageTag <GtPharoPackageTagCoder::TGtWithPharoPackageTagCoderModel>
"
]

{ #category : #'code generation' }
ManifestGToolkitPharoCoderUI class >> navigationViewModels [
"
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
]
