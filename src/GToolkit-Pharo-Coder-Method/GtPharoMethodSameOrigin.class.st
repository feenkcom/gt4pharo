Class {
	#name : #GtPharoMethodSameOrigin,
	#superclass : #GtPharoMethodOrigin,
	#instVars : [
		'behavior',
		'method'
	],
	#category : #'GToolkit-Pharo-Coder-Method-Origin'
}

{ #category : #accessing }
GtPharoMethodSameOrigin >> behavior [

	^ behavior
]

{ #category : #accessing }
GtPharoMethodSameOrigin >> behavior: anObject [

	behavior := anObject
]

{ #category : #accessing }
GtPharoMethodSameOrigin >> behavior: anObject method: aCompiledMethod [

	behavior := anObject.
	method := aCompiledMethod
]

{ #category : #accessing }
GtPharoMethodSameOrigin >> behaviorDo: aBlock ifUnknown: anUnknownBlock [
	"Evaluate a given block with the origin behavior"

	^ aBlock value: behavior
]

{ #category : #testing }
GtPharoMethodSameOrigin >> isSameOrigin [
	^ true
]

{ #category : #accessing }
GtPharoMethodSameOrigin >> method [
	^ method
]

{ #category : #accessing }
GtPharoMethodSameOrigin >> overriddenMethods [
	^ AsyncOverriddenMethodsStream forCompiledMethod: method
]

{ #category : #accessing }
GtPharoMethodSameOrigin >> overridingMethods [
	^ AsyncOverridingMethodsStream forCompiledMethod: method
]

{ #category : #accessing }
GtPharoMethodSameOrigin >> withInheritance [
	<return: #TAsyncFuture or: #GtPharoMethodSameOriginWithInheritance>
	
	^ (AsyncJoinAllFuture futures: {
		self overriddenMethods hasNext.
		self overridingMethods hasNext }) map: [ :aResult |
			GtPharoMethodSameOriginWithInheritance new
				behavior: behavior method: method;
				isOverriding: aResult first;
				isOverridden: aResult second ]
]
