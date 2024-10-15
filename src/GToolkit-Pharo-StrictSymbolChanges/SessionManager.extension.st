Extension { #name : #SessionManager }

{ #category : #'*GToolkit-Pharo-StrictSymbolChanges' }
SessionManager >> hasRegistered: handledId [
	"handledId, in most cases, will be a class name"

	^ self startupList
		anySatisfy: [ :handler | handler handledId sameContentAs: handledId ]
]
