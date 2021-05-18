Class {
	#name : #Gt2PharoSelectedPackageViewCoderViewModelChanged,
	#superclass : #Announcement,
	#instVars : [
		'selectedPackageViewCoderViewModel'
	],
	#category : #'GToolkit-Pharo-Coder2-Package Coder - Events'
}

{ #category : #generated }
Gt2PharoSelectedPackageViewCoderViewModelChanged >> selectedPackageViewCoderViewModel [
	<objectGetter: #packageView>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectGetterTemplate'>

	^ selectedPackageViewCoderViewModel
]

{ #category : #generated }
Gt2PharoSelectedPackageViewCoderViewModelChanged >> selectedPackageViewCoderViewModel: aSelectedPackageViewCoderViewModel [
	<objectSetter: #packageView>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectSetterTemplate'>

	selectedPackageViewCoderViewModel := aSelectedPackageViewCoderViewModel
]
