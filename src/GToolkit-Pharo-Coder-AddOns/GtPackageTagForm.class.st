Class {
	#name : #GtPackageTagForm,
	#superclass : #Object,
	#instVars : [
		'packageAndTagName',
		'onAccept'
	],
	#category : 'GToolkit-Pharo-Coder-AddOns-Extract method'
}

{ #category : #accessing }
GtPackageTagForm >> category [
	^ packageAndTagName category asSymbol
]

{ #category : #accessing }
GtPackageTagForm >> initialize [
	super initialize.
	packageAndTagName := GtPackageAndTagName new.
	onAccept := [  ]
]

{ #category : #accessing }
GtPackageTagForm >> magritteAcceptAction [
	<magritteActionDescription>
	^ super magritteAcceptAction
		label: 'Accept';
		onSuccessCallback: (GtMagritteCallback new
				action: [ :aModel :aButton :aMemento :aDescription | onAccept cull: aModel cull: aButton ]);
		beEnabledOnValidOverallStatus
]

{ #category : #accessing }
GtPackageTagForm >> magritteCancelAction [
	^ nil
]

{ #category : #accessing }
GtPackageTagForm >> onAccept [
	^ onAccept
]

{ #category : #accessing }
GtPackageTagForm >> onAccept: anObject [
	onAccept := anObject
]

{ #category : #accessing }
GtPackageTagForm >> packageAndTagDescription [
	<magritteDescription>
	^ GtPackageAndTagDescription new
		label: 'Package';
		priority: 3;
		accessor: #packageAndTagName;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		beRequired
]

{ #category : #accessing }
GtPackageTagForm >> packageAndTagName [
	^ packageAndTagName
]

{ #category : #accessing }
GtPackageTagForm >> packageAndTagName: anObject [
	packageAndTagName := anObject
]
