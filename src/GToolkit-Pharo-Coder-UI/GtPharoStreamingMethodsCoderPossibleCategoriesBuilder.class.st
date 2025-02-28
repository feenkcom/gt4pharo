Class {
	#name : #GtPharoStreamingMethodsCoderPossibleCategoriesBuilder,
	#superclass : #GtFilterModelItemsBuilder,
	#instVars : [
		'methodsCoder',
		'filterModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-Support'
}

{ #category : #'api - instantiation' }
GtPharoStreamingMethodsCoderPossibleCategoriesBuilder >> create [
	"Note that this method is deprecated and therefore does not return categories.
	Use #createFuture instead."

	^ {self firstItem}
]

{ #category : #'api - instantiation' }
GtPharoStreamingMethodsCoderPossibleCategoriesBuilder >> createFuture [
	^ methodsCoder possibleCategoriesOrderedFuture map: [ :aPrefixTree |
		(Array with: self firstItem withAll: aPrefixTree asArray)
			collect: #asFilterModelItem ].
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

{ #category : #'api - instantiation' }
GtPharoStreamingMethodsCoderPossibleCategoriesBuilder >> firstItem [
	^ GtAllProtocol defaultName asFilterModelItem
]

{ #category : #accessing }
GtPharoStreamingMethodsCoderPossibleCategoriesBuilder >> firstItemDo: aBlock [
	aBlock cull: self firstItem
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
