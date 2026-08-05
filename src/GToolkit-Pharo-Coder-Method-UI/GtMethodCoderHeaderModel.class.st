"
Provides data for displaying the header of a coder. The target behavioyr is the main behavioyr on which coder was opened. The provider behaviour is the one containing the actual implementation of the method.
"
Class {
	#name : #GtMethodCoderHeaderModel,
	#superclass : #Object,
	#instVars : [
		'packageName',
		'methodReceiverBehaviorName',
		'methodReceiverBehaviourIconName',
		'methodDefiningBehaviourName',
		'methodDefiningBehaviourIconName'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-Support'
}

{ #category : #'actions - spawning' }
GtMethodCoderHeaderModel >> createContextMenuMethodBehaviorFor: aCoderViewModel from: anElement phlowContext: aPhlowContext [
	<return: #BrMenuItems or: nil>
	^ nil
]

{ #category : #'actions - spawning' }
GtMethodCoderHeaderModel >> createContextMenuMethodReceiverBehaviorFor: aCoderViewModel from: anElement phlowContext: aPhlowContext [
	<return: #BrMenuItems or: nil>
	^ nil
]

{ #category : #'actions - spawning' }
GtMethodCoderHeaderModel >> createPackageContextMenuFor: aCoderViewModel from: anElement phlowContext: aPhlowContext [
	<return: #BrMenuItems or: nil>
	^ nil
]

{ #category : #testing }
GtMethodCoderHeaderModel >> hasMethodDefiningBehaviourData [
	^ self methodDefiningBehaviourName notNil
]

{ #category : #initialization }
GtMethodCoderHeaderModel >> initializeForCoderViewModel: aCoderViewModel [ 
	self subclassResponsibility
]

{ #category : #accessing }
GtMethodCoderHeaderModel >> methodDefiningBehaviourIconName [
	^ methodDefiningBehaviourIconName
]

{ #category : #accessing }
GtMethodCoderHeaderModel >> methodDefiningBehaviourName [
	^ methodDefiningBehaviourName
]

{ #category : #accessing }
GtMethodCoderHeaderModel >> methodReceiverBehaviourIconName [
	^ methodReceiverBehaviourIconName
]

{ #category : #accessing }
GtMethodCoderHeaderModel >> packageName [
	^ packageName
]

{ #category : #accessing }
GtMethodCoderHeaderModel >> providerBehaviourName [
	^ methodReceiverBehaviorName
]

{ #category : #'actions - spawning' }
GtMethodCoderHeaderModel >> spawnMethodDefiningBehaviorFor: aCoderViewModel from: anElement [
	self subclassResponsibility
]

{ #category : #'actions - spawning' }
GtMethodCoderHeaderModel >> spawnMethodReceiverBehaviorFor: aCoderViewModel from: anElement [
	self subclassResponsibility
]

{ #category : #'actions - spawning' }
GtMethodCoderHeaderModel >> spawnPackageFor: aCoderViewModel from: anElement [
	self subclassResponsibility
]
