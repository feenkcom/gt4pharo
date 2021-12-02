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
	^ {
		'AST-Core'.
		'Announcements-Core'.
		'Collections-Sequenceable'.
		'Collections-Strings'.
		'Collections-Unordered'.
		'GToolkit-Pharo-Parser'.
		'GToolkit-Pharo-System'.
		'GToolkit-Utility-Refactorings'.
		'Kernel'.
		'RPackage-Core'.
		'Refactoring-Changes'.
		'Refactoring-Core'.
		'Ring-Core'
	}
]

{ #category : #accessing }
ManifestGToolkitPharoMetamodels class >> shouldDependOn [
	^ {
		'GToolkit-Pharo-Parser'.
		'GToolkit-Pharo-System'.
		'GToolkit-Utility-Refactorings'.
		'Refactoring-Changes'.
		'Refactoring-Core'.
		'Ring-Core'
	}
]
