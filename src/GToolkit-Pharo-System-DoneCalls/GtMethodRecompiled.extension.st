Extension { #name : #GtMethodRecompiled }

{ #category : #'*GToolkit-Pharo-System-DoneCalls' }
GtMethodRecompiled >> gtDoneAnnouncementIn: anAnnouncer [
	#GtMethodRecompiledDone
		asClassIfPresent: [ :anAnnouncementClass | 
			anAnnouncer announce: (anAnnouncementClass methodChangedFrom: self oldMethod to: self newMethod) ]
]
