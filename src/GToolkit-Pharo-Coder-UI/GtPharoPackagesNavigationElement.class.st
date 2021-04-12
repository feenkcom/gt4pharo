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
	#name : #GtPharoPackagesNavigationElement,
	#superclass : #BrSimpleTree,
	#traits : 'TGtWithPharoPackagesNavigationViewModel',
	#classTraits : 'TGtWithPharoPackagesNavigationViewModel classTrait',
	#category : #'GToolkit-Pharo-Coder-UI-Navigation - Views'
}

{ #category : #initialization }
GtPharoPackagesNavigationElement >> initialize [
	super initialize.
	
	self withoutSelection.

	self nodeType: [ :aTypeFactory :aTreeNode |
		{
			#package -> GtPharoPackageNavigationElement.
			#tag -> GtPharoPackageTagNavigationElement.
			#class -> GtPharoPackageClassNavigationElement
		} asDictionary at: aTreeNode value viewModelName ].

	self nodeStencil: [ :anElementClass | anElementClass new ].

	self nodeDataBinder: [ :eachNodeElement :eachTreeNode |
		| aViewModelSetter |
		aViewModelSetter := {
			#package -> #pharoPackageNavigationViewModel:.
			#tag -> #pharoTagNavigationViewModel:.
			#class -> #pharoClassNavigationViewModel:
		} asDictionary at: eachTreeNode value viewModelName.
		eachNodeElement perform: aViewModelSetter with: eachTreeNode value ]
]

{ #category : #'api - pharo packages navigation view model' }
GtPharoPackagesNavigationElement >> onPharoPackagesNavigationViewModelChanged [
	"Is sent when a new pharoPackagesNavigation view model is assigned to the element.
	Note: #onPharoPackagesNavigationViewModelChanged is sent before #subscribeToPharoPackagesNavigationViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostPharoPackagesNavigationViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	| theItems |

	theItems := {
		#package -> [ :aViewModel | aViewModel pharoTagsNavigationViewModel pharoTagNavigationViewModels ].
		#tag -> [ :aViewModel | aViewModel pharoClassesNavigationViewModel pharoClassNavigationViewModels ].
		#class -> [ :aViewModel | #() ]
	} asDictionary.

	self
		items: self pharoPackagesNavigationViewModel pharoPackageNavigationViewModels
		lazy: [ :eachViewModel |
			| theItemsBlock |
			theItemsBlock := theItems at: eachViewModel viewModelName.
			theItemsBlock value: eachViewModel ]
]
