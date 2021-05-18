Class {
	#name : #Gt2PharoPackageViewCoderViewModelAddedAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'pharoPackageViewCoderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder2-Package Coder - Events'
}

{ #category : #generated }
Gt2PharoPackageViewCoderViewModelAddedAnnouncement >> pharoPackageViewCoderViewModel [
	<objectGetter: #packageView>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectGetterTemplate'>

	^ pharoPackageViewCoderViewModel
]

{ #category : #generated }
Gt2PharoPackageViewCoderViewModelAddedAnnouncement >> pharoPackageViewCoderViewModel: aPharoPackageViewCoderViewModel [
	<objectSetter: #packageView>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectSetterTemplate'>

	pharoPackageViewCoderViewModel := aPharoPackageViewCoderViewModel
]
