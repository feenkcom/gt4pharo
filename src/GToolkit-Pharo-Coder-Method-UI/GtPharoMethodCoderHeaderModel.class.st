Class {
	#name : #GtPharoMethodCoderHeaderModel,
	#superclass : #GtMethodCoderHeaderModel,
	#category : #'GToolkit-Pharo-Coder-Method-UI-Support'
}

{ #category : #initialization }
GtPharoMethodCoderHeaderModel >> initializeForBehaviour: aBehavior fromCoderViewModel: aCoderViewModel [
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
	targetBehaviourIconName := targetBehaviorClass systemIconName.
	
	providerBehaviorClass ifNotNil: [
		providerBehaviourName := providerBehaviorClass name.
		providerBehaviourIconName := providerBehaviorClass systemIconName. ]
]

{ #category : #initialization }
GtPharoMethodCoderHeaderModel >> initializeForCoderViewModel: aCoderViewModel [

	aCoderViewModel methodOrigin
		behaviorDo: [ :aBehavior |
			self 
				initializeForBehaviour: aBehavior
				fromCoderViewModel: aCoderViewModel ]
		ifUnknown: [
			self initializeForUnknownBehaviour ]
]

{ #category : #initialization }
GtPharoMethodCoderHeaderModel >> initializeForUnknownBehaviour [
	packageName := 'Unknown'.
	targetBehaviourName := 'Unknown'.
]

{ #category : #'actions - spawning' }
GtPharoMethodCoderHeaderModel >> spawnBehaviorFor: aCoderViewModel  from: anElement [
	aCoderViewModel methodOrigin behaviorDo: [ :aBehavior |
		anElement phlow spawnTool: (GtMethodCoderTool 
			compiledMethod: aCoderViewModel compiledMethod) ]
]

{ #category : #'actions - spawning' }
GtPharoMethodCoderHeaderModel >> spawnPackageFor: aCoderViewModel from: anElement [
	aCoderViewModel methodOrigin  behaviorDo: [ :aBehavior |
		anElement phlow 
			spawnTool: (GtPackageCoderTool package: aBehavior package) ]
]
