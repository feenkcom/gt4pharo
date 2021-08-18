Class {
	#name : 'GtSearchDeprecatedPackagesFilter',
	#superclass : 'GtSearchPackagesFilter',
	#category : 'GToolkit-Pharo-Coder-Filters'
}

{ #category : 'testing' }
GtSearchDeprecatedPackagesFilter >> includesPackage: aPackage [
	^ aPackage isDeprecated
]
