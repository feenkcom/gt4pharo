Class {
	#name : #GtPharoMethodCoderHeaderModel,
	#superclass : #GtMethodCoderHeaderModel,
	#category : #'GToolkit-Pharo-Coder-Method-UI-Support'
}

{ #category : #'actions - spawning' }
GtPharoMethodCoderHeaderModel >> createContextMenuMethodBehaviorFor: aCoderViewModel from: anElement phlowContext: aPhlowContext [
	"Create a context menu for a behavior that implements a method."

	<return: #BrMenuItems or: nil>
	^ aCoderViewModel methodOrigin
		originalMethodDo: [ :aMethodBehavior :aMethod | 
			aPhlowContext coderCompiledMethod: aMethod.
			GtCoderClassTarget
				menuItemsForObject: aMethodBehavior
				inContext: aPhlowContext
				hostElement: anElement ]
		ifUnknown: [ aCoderViewModel coderModel methodBehavior
				realBehaviorDo: [ :aBehavior | 
					GtCoderClassTarget
						menuItemsForObject: aBehavior
						inContext: aPhlowContext
						hostElement: anElement ]
				ifAbsent: [ nil ] ]
]

{ #category : #'actions - spawning' }
GtPharoMethodCoderHeaderModel >> createContextMenuMethodReceiverBehaviorFor: aCoderViewModel from: anElement phlowContext: aPhlowContext [
	"Create a context menu for a provider behavior, which is either aCoderViewModel selfObject class or aCoderViewModel behavior."

	<return: #BrMenuItems or: nil>
	| aProviderBehavior |
	aProviderBehavior := aCoderViewModel
			ifSelfObject: [ :aSelfObject | aSelfObject class instanceSide ]
			ifNone: [ aCoderViewModel explicitReceiverClass ifNil: [ aCoderViewModel behavior ] ].

	^ aCoderViewModel methodOrigin
		originalMethodDo: [ :aMethodBehavior :aMethod | 
			aMethodBehavior = aProviderBehavior
				ifTrue: [ self
						createContextMenuMethodBehaviorFor: aCoderViewModel
						from: anElement
						phlowContext: aPhlowContext ]
				ifFalse: [ 
					aPhlowContext coderCompiledMethod: aMethod.
					GtCoderClassTarget
						menuItemsForObject: aProviderBehavior
						inContext: aPhlowContext
						hostElement: anElement ] ]
		ifUnknown: [ aCoderViewModel coderModel methodBehavior
				realBehaviorDo: [ :aMethodBehavior | 
					aMethodBehavior = aProviderBehavior
						ifTrue: [ self
								createContextMenuMethodBehaviorFor: aCoderViewModel
								from: anElement
								phlowContext: aPhlowContext ]
						ifFalse: [ GtCoderClassTarget
								menuItemsForObject: aProviderBehavior
								inContext: aPhlowContext
								hostElement: anElement ] ]
				ifAbsent: [ nil ] ]
]

{ #category : #'actions - spawning' }
GtPharoMethodCoderHeaderModel >> createPackageContextMenuFor: aCoderViewModel from: anElement phlowContext: aPhlowContext [
	"Create a context menu for a provider behavior, which is either aCoderViewModel selfObject class or aCoderViewModel behavior."

	<return: #BrMenuItems or: nil>
	| aPackage |
	aPackage := aCoderViewModel compiledMethod ifNotNil: #package ifNil: [ ^ nil ].

	^ GtCoderPackageTarget
		menuItemsForObject: aPackage
		inContext: aPhlowContext
		hostElement: anElement
]

{ #category : #initialization }
GtPharoMethodCoderHeaderModel >> initializeForBehaviour: aBehavior fromCoderViewModel: aCoderViewModel [
	| explicitReceiverClass methodReceiverBehaviorClass methodDefiningBehaviorClass |
	
	packageName := aBehavior package name.
	
	explicitReceiverClass := aCoderViewModel explicitReceiverClass.
	(explicitReceiverClass isNil or: [ explicitReceiverClass = aBehavior ])
		ifTrue: [ 
			methodReceiverBehaviorClass := aBehavior.
			methodDefiningBehaviorClass := nil. ]
		ifFalse: [ 
			methodReceiverBehaviorClass := explicitReceiverClass.
			methodDefiningBehaviorClass := aBehavior ].
	
	methodReceiverBehaviorName := methodReceiverBehaviorClass name.
	methodReceiverBehaviourIconName := methodReceiverBehaviorClass systemIconName.
	
	methodDefiningBehaviorClass ifNotNil: [
		methodDefiningBehaviourName := methodDefiningBehaviorClass name.
		methodDefiningBehaviourIconName := methodDefiningBehaviorClass systemIconName. ]
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
	methodReceiverBehaviorName := 'Unknown'.
]

{ #category : #'actions - spawning' }
GtPharoMethodCoderHeaderModel >> spawnMethodDefiningBehaviorFor: aCoderViewModel from: anElement [
	"Spawn a behavior that implements a method. It can be Class or Trait. 
	Display also the given method."

	aCoderViewModel methodOrigin
		originalMethodDo: [ :aMethodBehavior :aMethod | 
			anElement phlow
				spawnTool: (GtMethodCoderTool
						compiledMethod: aMethod
						selfObjectHolder: aCoderViewModel selfObjectHolder) ]
		ifUnknown: [ aCoderViewModel coderModel methodBehavior
				realBehaviorDo: [ :aBehavior | 
					anElement phlow
						spawnTool: (GtClassCoderTool
								forClass: aBehavior
								selfObjectHolder: aCoderViewModel selfObjectHolder) ]
				ifAbsent: [  "do nothing" ] ]
]

{ #category : #'actions - spawning' }
GtPharoMethodCoderHeaderModel >> spawnMethodReceiverBehaviorFor: aCoderViewModel from: anElement [
	"Spawn a method receiver behavior, which is either aCoderViewModel selfObject class or aCoderViewModel behavior."

	| aReceiverBehavior |
	aReceiverBehavior := aCoderViewModel
			ifSelfObject: [ :aSelfObject | aSelfObject class instanceSide ]
			ifNone: [ aCoderViewModel explicitProviderClass
					ifNil: [ aCoderViewModel methodOrigin isTraitOrigin
							ifTrue: [ aCoderViewModel methodOrigin trait ]
							ifFalse: [ aCoderViewModel behavior ] ] ].

	aCoderViewModel methodOrigin
		originalMethodDo: [ :aMethodDefiningBehavior :aMethod | 
			aMethodDefiningBehavior = aReceiverBehavior
				ifTrue: [ self spawnMethodDefiningBehaviorFor: aCoderViewModel from: anElement ]
				ifFalse: [ anElement phlow
						spawnTool: (GtClassCoderTool
								forClass: aReceiverBehavior
								selfObjectHolder: aCoderViewModel selfObjectHolder) ] ]
		ifUnknown: [ aCoderViewModel coderModel methodBehavior
				realBehaviorDo: [ :aMethodBehavior | 
					aMethodBehavior = aReceiverBehavior
						ifTrue: [ self spawnMethodDefiningBehaviorFor: aCoderViewModel from: anElement ]
						ifFalse: [ anElement phlow
								spawnTool: (GtClassCoderTool
										forClass: aReceiverBehavior
										selfObjectHolder: aCoderViewModel selfObjectHolder) ] ]
				ifAbsent: [  "do nothing" ] ]
]

{ #category : #'actions - spawning' }
GtPharoMethodCoderHeaderModel >> spawnPackageFor: aCoderViewModel from: anElement [
	aCoderViewModel methodOrigin  
		behaviorDo: [ :aBehavior |
			anElement phlow spawnTool: (GtPackageCoderTool forPackage: aBehavior package) ]
		ifUnknown: [
			aCoderViewModel coderModel methodBehavior
				realBehaviorDo: [ :aBehavior |
					anElement phlow spawnTool: (GtPackageCoderTool forPackage: aBehavior package) ] 
				ifAbsent: [ "do nothing" ] ]
]
