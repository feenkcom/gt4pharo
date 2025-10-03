Class {
	#name : #GtPharoBigMethodCoderViewModel,
	#superclass : #GtExpandableCoderViewModel,
	#traits : 'TGtCoderWithSelfObjectHolder + TGtCoderViewModelWithParentProperties',
	#classTraits : 'TGtCoderWithSelfObjectHolder classTrait + TGtCoderViewModelWithParentProperties classTrait',
	#category : #'GToolkit-Pharo-Coder-BigMethods-Coder'
}

{ #category : #converting }
GtPharoBigMethodCoderViewModel >> asEditorState [
	^BrTextEditorCompositeMemento new
]

{ #category : #'api - coder model' }
GtPharoBigMethodCoderViewModel >> behavior [
	^ self coderModel behavior
]

{ #category : #'api - coder model' }
GtPharoBigMethodCoderViewModel >> behavior: aBehavior [
	^ self coderModel behavior: aBehavior
]

{ #category : #accessing }
GtPharoBigMethodCoderViewModel >> compiledMethod [
	^self coderModel compiledMethod
]

{ #category : #accessing }
GtPharoBigMethodCoderViewModel >> completionStrategy [
	^GtCompletionStrategy new
]

{ #category : #'api - coder model' }
GtPharoBigMethodCoderViewModel >> compositeStyler [
	^ nil
]

{ #category : #'private - addons' }
GtPharoBigMethodCoderViewModel >> computeAddOnsFuture [
	"Return a future that will be resolved to coder addons"

	<return: #TAsyncFuture>
	^ [ | newAddOns aCoderModel |
	aCoderModel := self coderModel.
	newAddOns := aCoderModel newAddOns.
	aCoderModel initializeAddOns: newAddOns viewModel: self.
	newAddOns markAsUpdated.
	newAddOns ] asAsyncFuture
]

{ #category : #accessing }
GtPharoBigMethodCoderViewModel >> computeHeaderBreadcrumbModel [
	^ GtPharoMethodCoderHeaderModel new 
		initializeForCoderViewModel: self.
]

{ #category : #'api - actions' }
GtPharoBigMethodCoderViewModel >> contextActions [
	^#()
]

{ #category : #accessing }
GtPharoBigMethodCoderViewModel >> elementClass [
	^ GtPharoBigMethodExpandableSourceCoderElement
]

{ #category : #accessing }
GtPharoBigMethodCoderViewModel >> explicitProviderClass [
	^ self coderModel explicitProviderClass
]

{ #category : #'as yet unclassified' }
GtPharoBigMethodCoderViewModel >> headerElementClass [
	^ GtPharoMethodCoderHeaderElement
]

{ #category : #accessing }
GtPharoBigMethodCoderViewModel >> highlighter: aHighlighter [
]

{ #category : #accessing }
GtPharoBigMethodCoderViewModel >> isMeta [
	^self coderModel isMeta
]

{ #category : #'api - text' }
GtPharoBigMethodCoderViewModel >> isTextModifiedPromise [
	^[ false ] asAsyncPromise
]

{ #category : #'api - actions' }
GtPharoBigMethodCoderViewModel >> mainActions [
	^ self addOns wait mainActions
]

{ #category : #'api - coder model' }
GtPharoBigMethodCoderViewModel >> methodOrigin [
	^ coderModel methodOrigin
]

{ #category : #accessing }
GtPharoBigMethodCoderViewModel >> methodReference [
	^ self coderModel methodReference
]

{ #category : #'api - coder model' }
GtPharoBigMethodCoderViewModel >> protocolName [
	^ self coderModel protocolName
]

{ #category : #'as yet unclassified' }
GtPharoBigMethodCoderViewModel >> selector [
	^ self coderModel selector
]

{ #category : #accessing }
GtPharoBigMethodCoderViewModel >> shortcuts [
	^#()
]
