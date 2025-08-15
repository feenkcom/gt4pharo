Class {
	#name : #GtPharoBigMethodCoder,
	#superclass : #GtPharoMethodCoder,
	#category : #'GToolkit-Pharo-Coder-BigMethods-Coder'
}

{ #category : #'as yet unclassified' }
GtPharoBigMethodCoder >> asCoderViewModel [
	^ GtPharoBigMethodCoderViewModel new
		coder: self;
		yourself
]

{ #category : #'as yet unclassified' }
GtPharoBigMethodCoder >> initializeAddOns: addOns viewModel: aGtPharoMethodCoderViewModel [

	addOns
		addDropDownWithPreviewAction: 'Remove' translated
		icon: BrGlamorousVectorIcons remove
		action: [ :aButtonElement :aButtonModel :anEvent | self remove ]
		stencil: [ :element | self buildRemoveMethodLabel: element ]
		id: GtMethodCoderRemoveActionId.
	addOns
		addMainAction: 'Inspect Method' translated
		icon: BrGlamorousVectorIcons inspect
		action: [ :aCoderUIModel :anElement | 
			self 
				notifyObjectSpawn: aCoderUIModel methodReference
				requesterObject: aCoderUIModel ]
		id: GtMethodCoderInspectActionId.
	addOns
		addMainAction: 'Copy Method Name' translated
		icon: BrGlamorousVectorIcons clipboard
		action: [ :aCoderUIModel :anElement | self copyMethodNameToClipboard ]
		id: GtMethodCoderCopyActionId.
]
