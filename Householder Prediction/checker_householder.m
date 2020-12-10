function [score] = checker_part_3()
    t0 = clock ();
    #[n_rgb, n_rgb_max] = test("checker_rgb");
    #printf("RGB histogram: %d / %d teste trecute.\n", n_rgb, n_rgb_max);

    #[n_hsv, n_hsv_max] = test("checker_hsv");
    #printf("HSV histogram: %d / %d teste trecute.\n", n_hsv, n_hsv_max);

    [n_prediction, n_prediction_max] = test("checker_prediction");
    printf("Cat prediction: %d / %d teste trecute.\n", n_prediction, n_prediction_max);

    score = 20 * (n_prediction) / (n_prediction_max);
    printf("Punctaj total: %.2f\n", score);

    fout = fopen("results", "w");
    fprintf(fout, "%.2f", score);
    fclose(fout);
    elapsed_time = etime (clock (), t0)
endfunction
