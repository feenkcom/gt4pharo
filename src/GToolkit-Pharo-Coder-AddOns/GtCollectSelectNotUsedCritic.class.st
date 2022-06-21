Class {
	#name : #GtCollectSelectNotUsedCritic,
	#superclass : #GtSendNotUsedCritic,
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #accessing }
GtCollectSelectNotUsedCritic >> description [
	^ '#collect:, #select:, and #reject: return new collections. If they are not used, they could be changed to use #do:.'
]

{ #category : #private }
GtCollectSelectNotUsedCritic >> fixItActionsFor: aNode using: aCriticStyler [
	^ {(GtRenameMessageFixItAction forCoder: aCriticStyler coderModel node: aNode)
			selector: #do:;
			yourself} , (super fixItActionsFor: aNode using: aCriticStyler)
]

{ #category : #accessing }
GtCollectSelectNotUsedCritic >> selectors [
	^ #(collect: select: reject:)
]
