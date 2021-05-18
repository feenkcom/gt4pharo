Class {
	#name : #Gt2PharoSelectedPackageCoderViewModelChanged,
	#superclass : #Announcement,
	#instVars : [
		'selectedPackageCoderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder2-Events'
}

{ #category : #generated }
Gt2PharoSelectedPackageCoderViewModelChanged >> selectedPackageCoderViewModel [
	<objectGetter: #package>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectGetterTemplate'>

	^ selectedPackageCoderViewModel
]

{ #category : #generated }
Gt2PharoSelectedPackageCoderViewModelChanged >> selectedPackageCoderViewModel: aSelectedPackageCoderViewModel [
	<objectSetter: #package>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectSetterTemplate'>

	selectedPackageCoderViewModel := aSelectedPackageCoderViewModel
]
