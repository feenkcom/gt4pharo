Extension { #name : #MethodModified }

{ #category : #'*GToolkit-Pharo-System' }
MethodModified >> gtDoneAnnouncementIn: anAnnouncer [
	#GtMethodModifiedDone
		asClassIfPresent: [ :anAnnouncementClass | 
			anAnnouncer announce: (anAnnouncementClass methodChangedFrom: self oldMethod to: self newMethod oldProtocol: self oldProtocol) ]
]
