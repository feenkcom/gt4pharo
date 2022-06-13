Class {
	#name : #GtCollectSelectNotUsedCritic,
	#superclass : #GtSendNotUsedCritic,
	#category : #'GToolkit-Pharo-Coder-AddOns-Critics'
}

{ #category : #accessing }
GtCollectSelectNotUsedCritic >> description [
	^ '#collect:, #select:, and #reject return new collections. If they are not used, they could be changed to use #do:.'
]

{ #category : #private }
GtCollectSelectNotUsedCritic >> fixItActionsFor: aNode from: sourceCoder [
	^ {(GtRenameMessageFixItAction forCoder: sourceCoder node: aNode)
			selector: #do:;
			yourself} , (super fixItActionsFor: aNode from: sourceCoder)
]

{ #category : #accessing }
GtCollectSelectNotUsedCritic >> selectors [
	^ #(collect: select: reject:)
]
