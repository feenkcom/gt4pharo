Extension { #name : #LeExampleSnippet }

{ #category : #'*GToolkit-Pharo-StrictSymbolChanges' }
LeExampleSnippet >> handleSystemMethodAnnouncement: anAnnouncement [
	((exampleBehaviorName sameContentAs: anAnnouncement methodClass originalName)
		and: [ exampleSelector sameContentAs: anAnnouncement selector ])
		ifTrue: [ self notifyExampleSelectorChanged ]
]
