Extension { #name : #MethodRepackaged }

{ #category : #'*GToolkit-Pharo-System' }
MethodRepackaged >> gtDoneAnnouncementIn: anAnnouncer [
	#GtMethodRepackagedDone
		asClassIfPresent: [ :anAnnouncementClass | 
			anAnnouncer announce: (anAnnouncementClass methodRepackaged: self method oldPackage: self oldPackage newPackage: self newPackage) ]
]
