Class {
	#name : #Gt2PharoPackageCoderViewModelRemovedAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'pharoPackageCoderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder2-Events'
}

{ #category : #generated }
Gt2PharoPackageCoderViewModelRemovedAnnouncement >> pharoPackageCoderViewModel [
	<objectGetter: #package>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectGetterTemplate'>

	^ pharoPackageCoderViewModel
]

{ #category : #generated }
Gt2PharoPackageCoderViewModelRemovedAnnouncement >> pharoPackageCoderViewModel: aPharoPackageCoderViewModel [
	<objectSetter: #package>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectSetterTemplate'>

	pharoPackageCoderViewModel := aPharoPackageCoderViewModel
]
