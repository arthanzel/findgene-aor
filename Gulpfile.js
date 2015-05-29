var gulp = require("gulp");

// ============================
// ====== Asset Pipeline ======
// ============================

var autoprefixer = require("gulp-autoprefixer");
var stylus = require("gulp-stylus");

gulp.task("build:stylus", function() {
    gulp.src("public/assets/css/findgene.styl")
        .pipe(stylus())
        .pipe(autoprefixer())
        .pipe(gulp.dest("public/assets/css/"));
});

gulp.task("watch", function() {
    gulp.watch("public/assets/css/findgene.styl", ["build:stylus"]);
});