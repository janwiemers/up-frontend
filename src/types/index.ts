type monitorType = {
  id: number;
  name: string;
  interval: number;
  createdAt: string;
  protocol: string;
  target: string;
  expectation: string;
  checks: checkType[];
};

type checkType = {
  id: number;
  createdAt: string;
  up: boolean;
  applicationId: number;
};

export { checkType, monitorType };
