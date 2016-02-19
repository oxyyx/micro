var gulp =          require('gulp');
var sass =          require('gulp-sass');
var minifyCSS =     require('gulp-minify-css')
var concat =        require('gulp-concat');

// Common paths.
var paths = {
    BootstrapSCSS: 'priv/assets/bootstrap-custom/bootstrap-custom.scss',
    BootstrapInclude: 'priv/components/bootstrap-sass/assets/stylesheets',
}

// Build admin CSS from SASS/CSS
gulp.task('bootstrap-sass', function() {
    return gulp.src(paths.BootstrapSCSS)
        .pipe(sass({
            trace: true,
            style: 'compressed',
            includePaths: [paths.BootstrapInclude]
        }))
        .pipe(gulp.dest('priv/static/css'));
});

// Watch for changes.
gulp.task('watch', function () {
    gulp.watch(paths.BootstrapSCSS, ['bootstrap-sass']);
});

// Default gulp task.
gulp.task('default', ['bootstrap-sass']);