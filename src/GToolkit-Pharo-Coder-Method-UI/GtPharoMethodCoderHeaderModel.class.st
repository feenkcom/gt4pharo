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
			aCoderViewModel coderModel methodBehavior
				realBehaviorDo: [ :aBehavior |
					self 
						initializeForBehaviour: aBehavior
						fromCoderViewModel: aCoderViewModel ] 
				ifAbsent: [ self initializeForUnknownBehaviour ] ]
]

{ #category : #initialization }
GtPharoMethodCoderHeaderModel >> initializeForUnknownBehaviour [
	packageName := 'Unknown'.
	providerBehaviourName := 'Unknown'.
]

{ #category : #'actions - spawning' }
GtPharoMethodCoderHeaderModel >> spawnMethodBehaviorFor: aCoderViewModel from: anElement [
	"Spawn a behavior that implements a method. Display also the given method."
	self haltOnce.
	aCoderViewModel methodOrigin
		originalMethodDo: [ :aMethodBehavior :aMethod | 
			anElement phlow spawnTool: (GtMethodCoderTool compiledMethod: aMethod) ]
		ifUnknown: [
			aCoderViewModel coderModel methodBehavior
				realBehaviorDo: [ :aBehavior |
					anElement phlow spawnTool: (GtClassCoderTool forClass: aBehavior) ] 
				ifAbsent: [ "do nothing" ] ]
]

{ #category : #'actions - spawning' }
GtPharoMethodCoderHeaderModel >> spawnPackageFor: aCoderViewModel from: anElement [
	aCoderViewModel methodOrigin  
		behaviorDo: [ :aBehavior |
			anElement phlow spawnTool: (GtPackageCoderTool package: aBehavior package) ]
		ifUnknown: [
			aCoderViewModel coderModel methodBehavior
				realBehaviorDo: [ :aBehavior |
					anElement phlow spawnTool: (GtPackageCoderTool package: aBehavior package) ] 
				ifAbsent: [ "do nothing" ] ]
]

{ #category : #'actions - spawning' }
GtPharoMethodCoderHeaderModel >> spawnProviderBehaviorFor: aCoderViewModel from: anElement [
	"Spawn a provider behavior, which is either aCoderViewModel selfObject class or aCoderViewModel behavior."

	| aProviderBehavior |
	self haltOnce.
	aProviderBehavior := aCoderViewModel 
		ifSelfObject: [ :aSelfObject |
			aSelfObject class instanceSide ]
		ifNone: [ aCoderViewModel explicitProviderClass 
			ifNil: [ aCoderViewModel behavior ] ].
	
	aCoderViewModel methodOrigin
		originalMethodDo: [ :aMethodBehavior :aMethod | 
			aMethodBehavior = aProviderBehavior
				ifTrue: [ self spawnMethodBehaviorFor: aCoderViewModel from: anElement ]
				ifFalse: [ anElement phlow spawnTool: (GtClassCoderTool forClass: aProviderBehavior) ] ]
		ifUnknown: [
			aCoderViewModel coderModel methodBehavior
				realBehaviorDo: [ :aMethodBehavior |
					aMethodBehavior = aProviderBehavior
						ifTrue: [ self spawnMethodBehaviorFor: aCoderViewModel from: anElement ]
						ifFalse: [ anElement phlow spawnTool: (GtClassCoderTool forClass: aProviderBehavior) ] ] 
				ifAbsent: [ "do nothing" ] ]
]
