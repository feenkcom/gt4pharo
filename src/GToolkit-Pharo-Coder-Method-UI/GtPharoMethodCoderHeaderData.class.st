Class {
	#name : #GtPharoMethodCoderHeaderData,
	#superclass : #GtMethodCoderHeaderData,
	#category : #'GToolkit-Pharo-Coder-Method-UI-Support'
}

{ #category : #initialization }
GtPharoMethodCoderHeaderData >> initializeForBehaviour: aBehavior fromCoderViewModel: aCoderViewModel [
	| explicitProviderClass targetBehaviorClass providerBehaviorClass |
	
	packageName := aBehavior package name.
	
	explicitProviderClass := aCoderViewModel explicitProviderClass.
	(explicitProviderClass isNil or: [ explicitProviderClass = aBehavior ])
		ifTrue: [ 
			targetBehaviorClass := aBehavior.
			providerBehaviorClass := nil. ]
		ifFalse: [ 
			targetBehaviorClass := explicitProviderClass.
			providerBehaviorClass := aBehavior ].
	
	targetBehaviourName := targetBehaviorClass name.
	targetBehaviourIconName := targetBehaviorClass gtCustomSystemIconNameOrNil.
	
	providerBehaviorClass ifNotNil: [
		providerBehaviourName := providerBehaviorClass name.
		providerBehaviourIconName := providerBehaviorClass gtCustomSystemIconNameOrNil. ]
]

{ #category : #initialization }
GtPharoMethodCoderHeaderData >> initializeForCoderViewModel: aCoderViewModel [

	aCoderViewModel methodOrigin
		behaviorDo: [ :aBehavior |
			self 
				initializeForBehaviour: aBehavior
				fromCoderViewModel: aCoderViewModel ]
		ifUnknown: [
			self initializeForUnknownBehaviour ]
]

{ #category : #initialization }
GtPharoMethodCoderHeaderData >> initializeForUnknownBehaviour [
	packageName := 'Unknown'.
	targetBehaviourName := 'Unknown'.
]
