#load ".fake/build.fsx/intellisense.fsx"

open Fake.Core
open Fake.IO
open Fake.BuildServer
open Fake.Tools
open YoloDev.Fake.Tool.Docker.MultiArch

BuildServer.install [
  TeamFoundation.Installer
  Travis.Installer
]

let getGitversionPath (p: GitVersion.GitversionParams) =
  { p with ToolPath = ProcessUtils.tryFindFileOnPath "dotnet-gitversion" |> Option.get }

let IMAGE = "alxandr/dnsimple-updater"
let VERSION = (GitVersion.generateProperties getGitversionPath).FullSemVer

Trace.setBuildNumber VERSION

Target.create "Init" (fun _ ->
  Directory.create "build"
)

let targets =
  Target.Docker.MultiArch.build
  |> Target.Docker.MultiArch.addImage IMAGE VERSION "cross.Dockerfile"
  |> Target.Docker.MultiArch.addArch Amd64
  |> Target.Docker.MultiArch.addArch Arm64V8
  |> Target.Docker.MultiArch.setBuildDir "build"
  |> Target.Docker.MultiArch.updateLatestTag
  |> Target.Docker.MultiArch.addDependency "Init"
  |> Target.Docker.MultiArch.create

let ctx = Target.WithContext.runOrDefault targets.buildAll
Target.updateBuildStatus ctx
Target.raiseIfError ctx // important to have proper exit code on build failures.
