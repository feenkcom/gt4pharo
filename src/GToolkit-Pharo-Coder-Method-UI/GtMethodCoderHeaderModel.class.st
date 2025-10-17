"
Provides data for displaying the header of a coder. The target behavioyr is the main behavioyr on which coder was opened. The provider behaviour is the one containing the actual implementation of the method.
"
Class {
	#name : #GtMethodCoderHeaderModel,
	#superclass : #Object,
	#instVars : [
		'packageName',
		'methodBehaviourName',
		'methodBehaviourIconName',
		'providerBehaviourName',
		'providerBehaviourIconName'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-Support'
}

{ #category : #'actions - spawning' }
GtMethodCoderHeaderModel >> createContextMenuMethodBehaviorFor: aCoderViewModel from: anElement phlowContext: aPhlowContext [
	<return: #BrMenuItems or: nil>
	^ nil
]

{ #category : #'actions - spawning' }
GtMethodCoderHeaderModel >> createContextMenuProviderBehaviorFor: aCoderViewModel from: anElement phlowContext: aPhlowContext [
	<return: #BrMenuItems or: nil>
	^ nil
]

{ #category : #testing }
GtMethodCoderHeaderModel >> hasMethodBehaviourData [
	^ self methodBehaviourName notNil
]

{ #category : #initialization }
GtMethodCoderHeaderModel >> initializeForCoderViewModel: aCoderViewModel [ 
	self subclassResponsibility
]

{ #category : #accessing }
GtMethodCoderHeaderModel >> methodBehaviourIconName [
	^ methodBehaviourIconName
]

{ #category : #accessing }
GtMethodCoderHeaderModel >> methodBehaviourName [
	^ methodBehaviourName
]

{ #category : #accessing }
GtMethodCoderHeaderModel >> packageName [
	^ packageName
]

{ #category : #accessing }
GtMethodCoderHeaderModel >> providerBehaviourIconName [
	^ providerBehaviourIconName
]

{ #category : #accessing }
GtMethodCoderHeaderModel >> providerBehaviourName [
	^ providerBehaviourName
]

{ #category : #'actions - spawning' }
GtMethodCoderHeaderModel >> spawnMethodBehaviorFor: aCoderViewModel  from: anElement [
	self subclassResponsibility
]

{ #category : #'actions - spawning' }
GtMethodCoderHeaderModel >> spawnPackageFor: aCoderViewModel from: anElement [
	self subclassResponsibility
]

{ #category : #'actions - spawning' }
GtMethodCoderHeaderModel >> spawnProviderBehaviorFor: aCoderViewModel  from: anElement [
	self subclassResponsibility
]
