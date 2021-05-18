Class {
	#name : #Gt2PharoPackageActionCoderViewModelAddedAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'pharoPackageActionCoderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder2-Package Coder - Events'
}

{ #category : #generated }
Gt2PharoPackageActionCoderViewModelAddedAnnouncement >> pharoPackageActionCoderViewModel [
	<objectGetter: #packageAction>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectGetterTemplate'>

	^ pharoPackageActionCoderViewModel
]

{ #category : #generated }
Gt2PharoPackageActionCoderViewModelAddedAnnouncement >> pharoPackageActionCoderViewModel: aPharoPackageActionCoderViewModel [
	<objectSetter: #packageAction>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectSetterTemplate'>

	pharoPackageActionCoderViewModel := aPharoPackageActionCoderViewModel
]
