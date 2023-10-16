Extension { #name : #ClassAnnouncement }

{ #category : #'*GToolkit-Pharo-Extensions' }
ClassAnnouncement >> gtDisplayOn: aStream [
	super gtDisplayOn: aStream.
	aStream 
		parenthesize: [
			aStream << self classAffected name ]
]
