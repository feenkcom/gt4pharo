Class {
	#name : #GtPharoMethodCoderHeaderModel,
	#superclass : #GtMethodCoderHeaderModel,
	#category : #'GToolkit-Pharo-Coder-Method-UI-Support'
}

{ #category : #initialization }
GtPharoMethodCoderHeaderModel >> initializeForBehaviour: aBehavior fromCoderViewModel: aCoderViewModel [
	| explicitProviderClass providerBehaviorClass methodBehaviorClass |
	
	packageName := aBehavior package name.
	
	explicitProviderClass := aCoderViewModel explicitProviderClass.
	(explicitProviderClass isNil or: [ explicitProviderClass = aBehavior ])
		ifTrue: [ 
			providerBehaviorClass := aBehavior.
			methodBehaviorClass := nil. ]
		ifFalse: [ 
			providerBehaviorClass := explicitProviderClass.
			methodBehaviorClass := aBehavior ].
	
	providerBehaviourName := providerBehaviorClass name.
	providerBehaviourIconName := providerBehaviorClass systemIconName.
	
	methodBehaviorClass ifNotNil: [
		methodBehaviourName := methodBehaviorClass name.
		methodBehaviourIconName := methodBehaviorClass systemIconName. ]
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
	providerBehaviourName := 'Unknown'.
]

{ #category : #'actions - spawning' }
GtPharoMethodCoderHeaderModel >> spawnBehaviorFor: aCoderViewModel from: anElement [
	aCoderViewModel methodOrigin
		originalMethodDo: [ :aBehavior :aMethod | anElement phlow spawnTool: (GtMethodCoderTool compiledMethod: aMethod) ]
		ifUnknown: [  ]
]

{ #category : #'actions - spawning' }
GtPharoMethodCoderHeaderModel >> spawnContainerBehaviorFor: aCoderViewModel from: anElement [
	aCoderViewModel methodOrigin
		originalMethodDo: [ :aBehavior :aMethod | anElement phlow spawnTool: (GtMethodCoderTool compiledMethod: aMethod) ]
		ifUnknown: [  ]
]

{ #category : #'actions - spawning' }
GtPharoMethodCoderHeaderModel >> spawnPackageFor: aCoderViewModel from: anElement [
	aCoderViewModel methodOrigin  behaviorDo: [ :aBehavior |
		anElement phlow 
			spawnTool: (GtPackageCoderTool package: aBehavior package) ]
]
