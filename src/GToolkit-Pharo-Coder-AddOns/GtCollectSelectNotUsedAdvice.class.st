Class {
	#name : #GtCollectSelectNotUsedAdvice,
	#superclass : #GtSendNotUsedAdvice,
	#category : #'GToolkit-Pharo-Coder-AddOns-MethodAdvices'
}

{ #category : #accessing }
GtCollectSelectNotUsedAdvice >> description [
	^ '#collect:, #select:, and #reject: return new collections. If they are not used, they could be changed to use #do:.'
]

{ #category : #private }
GtCollectSelectNotUsedAdvice >> fixItActionsFor: aNode using: aCriticStyler [
	^ {(GtRenameMessageFixItAction forCoder: aCriticStyler coderModel node: aNode)
			selector: #do:;
			yourself} , (super fixItActionsFor: aNode using: aCriticStyler)
]

{ #category : #accessing }
GtCollectSelectNotUsedAdvice >> selectors [
	^ #(collect: select: reject:)
]
