Class {
	#name : #GtPharoStreamingMethodsCoderPossibleCategoriesBuilder,
	#superclass : #GtFilterModelItemsBuilder,
	#instVars : [
		'methodsCoder',
		'filterModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Support'
}

{ #category : #'as yet unclassified' }
GtPharoStreamingMethodsCoderPossibleCategoriesBuilder >> create [
	^ {GtAllProtocol defaultName} , methodsCoder possibleCategories asArray
		collect: #asFilterModelItem
]

{ #category : #accessing }
GtPharoStreamingMethodsCoderPossibleCategoriesBuilder >> filterModel [
	^ filterModel
]

{ #category : #accessing }
GtPharoStreamingMethodsCoderPossibleCategoriesBuilder >> filterModel: aFilterModel [
	self
		assert: [ filterModel isNil ]
		description: [ 'Filter model can be initialized only once' ].
	filterModel := aFilterModel
]

{ #category : #accessing }
GtPharoStreamingMethodsCoderPossibleCategoriesBuilder >> methodsCoder [
	^ methodsCoder
]

{ #category : #accessing }
GtPharoStreamingMethodsCoderPossibleCategoriesBuilder >> methodsCoder: aMethodsCoder [
	methodsCoder := aMethodsCoder.
	
	aMethodsCoder 
		when: GtStreamingCodersStreamChanged
		send: #onStreamChanged:
		to: self
]

{ #category : #'event handling' }
GtPharoStreamingMethodsCoderPossibleCategoriesBuilder >> onStreamChanged: anAnnouncement [
	self filterModel ifNil: [ ^ self ].
	self filterModel notifyItemsChanged
]
