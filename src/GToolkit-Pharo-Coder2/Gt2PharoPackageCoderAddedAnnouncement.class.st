Class {
	#name : #Gt2PharoPackageCoderAddedAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'pharoPackageCoder'
	],
	#category : #'GToolkit-Pharo-Coder2-Events'
}

{ #category : #generated }
Gt2PharoPackageCoderAddedAnnouncement >> pharoPackageCoder [
	<objectGetter: #package>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectGetterTemplate'>

	^ pharoPackageCoder
]

{ #category : #generated }
Gt2PharoPackageCoderAddedAnnouncement >> pharoPackageCoder: aPharoPackageCoder [
	<objectSetter: #package>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectSetterTemplate'>

	pharoPackageCoder := aPharoPackageCoder
]
