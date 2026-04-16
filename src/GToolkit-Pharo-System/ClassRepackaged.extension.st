Extension { #name : #ClassRepackaged }

{ #category : #'*GToolkit-Pharo-System' }
ClassRepackaged >> gtDoneAnnouncementIn: anAnnouncer [
	#GtClassRepackagedDone
		asClassIfPresent: [ :anAnnouncementClass |
			anAnnouncer announce: (anAnnouncementClass
				classRepackaged: self classAffected
				oldTag: self oldTag
				newTag: self newTag) ]
]
