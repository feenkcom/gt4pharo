"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestGToolkitPharoMetamodels,
	#superclass : #PackageManifest,
	#category : #'GToolkit-Pharo-Metamodels-Manifest'
}

{ #category : #accessing }
ManifestGToolkitPharoMetamodels class >> mustOnlyDependOn [
	"Please note that metamodels should be a low level package with as little dependencies on the
	rest of GToolkit as possible. The package should definitely depend on UI."
	^ {
		'AST-Core'.
		'Announcements-Core'.
		'Collections-Sequenceable'.
		'Collections-Strings'.
		'Collections-Unordered'.
		'Futures'.
		'GToolkit-Pharo-Parser'.
		'GToolkit-Pharo-System'.
		'GToolkit-Pharo-GtRefactorings'.
		'GToolkit-Pharo-BaseRefactorings'.
		'Kernel'.
		'Metacello-Base'.
		'Refactoring-Changes'.
		'Ring-Core'.
	}, (self  
		forPharo12: [{
			'Kernel-CodeModel'.
			'GToolkit-Pharo11Stubs'}] 
		forPharo11AndPharo10: [{
			'RPackage-Core'.
			'GToolkit-Pharo12Stubs'}])
]

{ #category : #accessing }
ManifestGToolkitPharoMetamodels class >> shouldDependOn [
	^ {
		'GToolkit-Pharo-Parser'.
		'GToolkit-Pharo-System'.
		'GToolkit-Pharo-GtRefactorings'.
		'GToolkit-Pharo-BaseRefactorings'.
		'Refactoring-Changes'.
		'Ring-Core'.
	}, (self  
		forPharo12: [{
			'GToolkit-Pharo11Stubs'}] 
		forPharo11AndPharo10: [{
			'GToolkit-Pharo12Stubs'}])
]
