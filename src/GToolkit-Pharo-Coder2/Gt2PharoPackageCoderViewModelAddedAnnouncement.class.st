Class {
	#name : #Gt2PharoPackageCoderViewModelAddedAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'pharoPackageCoderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder2-Package Coder - Events'
}

{ #category : #generated }
Gt2PharoPackageCoderViewModelAddedAnnouncement >> pharoPackageCoderViewModel [
	<objectGetter: #package>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectGetterTemplate'>

	^ pharoPackageCoderViewModel
]

{ #category : #generated }
Gt2PharoPackageCoderViewModelAddedAnnouncement >> pharoPackageCoderViewModel: aPharoPackageCoderViewModel [
	<objectSetter: #package>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectSetterTemplate'>

	pharoPackageCoderViewModel := aPharoPackageCoderViewModel
]
