val sdkRegistryToken: String? by project

allprojects {
    repositories {
        google()
        mavenCentral()
              maven {
            url = uri("https://api.mapbox.com/downloads/v2/releases/maven")
            credentials {
                username = "mapbox"
                password = sdkRegistryToken
            }
            authentication {
                create<BasicAuthentication>("basic")
            }
              }
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
   
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

  