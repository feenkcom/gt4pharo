Class {
	#name : #GtCollectSelectNotUsedAdvice,
	#superclass : #GtSendNotUsedAdvice,
	#category : 'GToolkit-Pharo-Coder-AddOns-MethodAdvices'
}

{ #category : #accessing }
GtCollectSelectNotUsedAdvice >> description [
	^ '#collect:, #select:, and #reject: return new collections. If they are not used, they could be changed to use #do:.'
]

{ #category : #private }
GtCollectSelectNotUsedAdvice >> fixItActionsForNode: aNode coderModel: coderModel [
	^ {(GtRenameMessageFixItAction forCoder: coderModel node: aNode)
			selector: #do:;
			yourself} , (super fixItActionsForNode: aNode coderModel: coderModel)
]

{ #category : #accessing }
GtCollectSelectNotUsedAdvice >> selectors [
	^ #(collect: select: reject:)
]
